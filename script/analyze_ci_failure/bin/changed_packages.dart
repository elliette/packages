// Copyright 2013 The Flutter Authors
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:analyze_ci_failure/ci_lib.dart' as ci_lib;
import 'package:analyze_ci_failure/package_selection.dart';
import 'package:args/args.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

String? _run(List<String> cmd, {String? cwd}) {
  try {
    final ProcessResult result = Process.runSync(cmd.first, cmd.sublist(1), workingDirectory: cwd);
    return result.exitCode == 0 ? result.stdout as String : null;
  } on ProcessException {
    return null;
  }
}

List<String> _lines(String text) =>
    text.split('\n').map((String l) => l.trim()).where((String l) => l.isNotEmpty).toList();

bool _isCheckout(String repoRoot) {
  // This cannot just test for a `.git` *directory*: in a git worktree (common
  // for tree-gardening setups) `.git` is a regular file.
  return _run(<String>['git', 'rev-parse', '--git-dir'], cwd: repoRoot) != null;
}

String? _revParse(String ref, String repoRoot) =>
    _run(<String>['git', 'rev-parse', '$ref^{commit}'], cwd: repoRoot)?.trim();

// --------------------------------------------------------------------------
// Mode 1: flutter_plugin_tools (authoritative)
// --------------------------------------------------------------------------

List<String>? _toolCommand(String repoRoot) {
  final String? override = Platform.environment['FPT'];
  if (override != null && override.isNotEmpty) {
    return override.split(' ');
  }
  final String entrypoint = p.join(repoRoot, 'script', 'tool', 'bin', 'flutter_plugin_tools.dart');
  if (File(entrypoint).existsSync()) {
    // Prefer the checkout's own copy so the rules match the branch analyzed.
    return <String>['dart', 'run', entrypoint];
  }
  return null;
}

Map<String, dynamic>? _packagesViaTool(String sha, String repoRoot) {
  final List<String>? command = _toolCommand(repoRoot);
  if (command == null) {
    return null;
  }
  final String? out = _run(<String>[
    ...command,
    'list',
    '--run-on-changed-packages',
    '--base-sha=$sha^',
  ], cwd: repoRoot);
  if (out == null) {
    return null;
  }

  final packages = <String>[];
  var fullTest = false;
  for (final String line in _lines(out)) {
    if (line.contains(fullTestMessage)) {
      fullTest = true;
    } else if (line.startsWith(repoRoot + p.separator)) {
      packages.add(p.relative(line, from: repoRoot));
    }
  }
  if (packages.isEmpty && !fullTest) {
    return null;
  }

  return <String, dynamic>{
    'mode': 'flutter_plugin_tools (authoritative)',
    'packages': packages..sort(),
    'full_test': fullTest,
  };
}

// --------------------------------------------------------------------------
// Mode 2: file list + local rules (fallback)
// --------------------------------------------------------------------------

List<String>? _filesFromGit(String ref, String repoRoot) {
  final String? out = _run(<String>['git', 'show', '--name-only', '--format=', ref], cwd: repoRoot);
  return out == null ? null : _lines(out);
}

List<String>? _filesFromGhPr(int pr, String repo) {
  final String? out = _run(<String>[
    'gh',
    'pr',
    'diff',
    pr.toString(),
    '--repo',
    repo,
    '--name-only',
  ]);
  return out == null ? null : _lines(out);
}

Future<dynamic> _getGitHubJson(String url) async {
  final http.Response response = await http.get(
    Uri.parse(url),
    headers: const <String, String>{'Accept': 'application/vnd.github+json'},
  );
  if (response.statusCode != 200) {
    throw Exception('HTTP ${response.statusCode} from $url');
  }
  return jsonDecode(response.body);
}

// The GitHub REST API caps these listings (3000 files for a PR, 300 for a
// commit), and is rate limited to 60 requests/hour without auth.
const int _perPage = 100;
const int _maxPrFiles = 3000;
const int _maxCommitFiles = 300;

Future<List<String>?> _filesFromApi(String repo, {int? pr, String? commit}) async {
  try {
    final files = <String>[];
    if (pr != null) {
      for (var page = 1; ; page++) {
        final data =
            await _getGitHubJson(
                  'https://api.github.com/repos/$repo/pulls/$pr/files'
                  '?per_page=$_perPage&page=$page',
                )
                as List<dynamic>;
        files.addAll(data.map((dynamic e) => (e as Map<String, dynamic>)['filename'] as String));
        if (data.length < _perPage) {
          break;
        }
      }
      if (files.length >= _maxPrFiles) {
        ci_lib.log(
          'WARNING: GitHub lists at most $_maxPrFiles files per PR; the '
          'package list may be incomplete.',
        );
      }
    } else {
      final data =
          await _getGitHubJson('https://api.github.com/repos/$repo/commits/$commit')
              as Map<String, dynamic>;
      files.addAll(
        (data['files'] as List<dynamic>? ?? <dynamic>[]).map(
          (dynamic e) => (e as Map<String, dynamic>)['filename'] as String,
        ),
      );
      if (files.length >= _maxCommitFiles) {
        ci_lib.log(
          'WARNING: GitHub lists at most $_maxCommitFiles files per commit; '
          'the package list may be incomplete. Use --repo-root for a full '
          'answer.',
        );
      }
    }
    return files;
  } on Exception catch (e) {
    ci_lib.log('GitHub API lookup failed: $e');
    return null;
  }
}

String _short(String? sha) => sha == null ? '?' : ci_lib.truncate(sha, 9);

Future<void> main(List<String> args) async {
  final parser = ArgParser()
    ..addOption('pr', help: 'GitHub PR number.')
    ..addOption('commit', help: 'Full commit SHA.')
    ..addOption('repo', defaultsTo: ci_lib.defaultRepo, help: 'owner/name.')
    ..addOption('repo-root', help: 'Local checkout to use.')
    ..addFlag(
      'fpt',
      defaultsTo: true,
      help:
          'Use flutter_plugin_tools when possible. --no-fpt forces the '
          'heuristic fallback.',
    )
    ..addFlag('json', help: 'Output as JSON.');

  final ArgResults parsedArgs;
  final int? pr;
  try {
    parsedArgs = parser.parse(args);
    if (parsedArgs['pr'] == null && parsedArgs['commit'] == null) {
      throw const FormatException('Must specify either --pr or --commit');
    }
    if (parsedArgs['pr'] != null && parsedArgs['commit'] != null) {
      throw const FormatException('Cannot specify both --pr and --commit');
    }
    final prArg = parsedArgs['pr'] as String?;
    pr = prArg == null ? null : int.parse(prArg);
  } on FormatException catch (e) {
    stderr.writeln('Error: ${e.message}');
    stderr.writeln(parser.usage);
    exit(1);
  }

  final commit = parsedArgs['commit'] as String?;
  final repo = parsedArgs['repo'] as String;
  final json = parsedArgs['json'] as bool;
  final String repoRoot = p.normalize(
    p.absolute(parsedArgs['repo-root'] as String? ?? Directory.current.path),
  );
  final bool hasCheckout = _isCheckout(repoRoot);

  // --- Mode 1 -----------------------------------------------------------
  if (commit != null && hasCheckout && (parsedArgs['fpt'] as bool)) {
    final String? target = _revParse(commit, repoRoot);
    final String? head = _revParse('HEAD', repoRoot);

    if (target != null && target == head) {
      final Map<String, dynamic>? result = _packagesViaTool(commit, repoRoot);
      if (result != null) {
        final List<String> rolls = sdkRolls(_filesFromGit(commit, repoRoot) ?? <String>[]);
        result['source'] = 'local git';
        result['sdk_rolls'] = rolls;

        if (json) {
          print(jsonEncode(result));
          return;
        }

        final packages = result['packages'] as List<String>;
        print('mode: ${result['mode']}');
        if (result['full_test'] == true) {
          print(
            '\nThis change touches repo-wide infrastructure, so '
            'flutter_plugin_tools selects ALL ${packages.length} packages:\n'
            '  "Running for all packages, since a file has changed that could '
            'affect the entire repository."',
          );
          print(
            rolls.isNotEmpty
                ? rollWarning(rolls)
                : 'A failure in a package this change never touched is '
                      'therefore expected noise, not a regression.',
          );
          return;
        }

        print('\nchanged packages (${packages.length}):');
        for (final package in packages) {
          print('  $package');
        }
        return;
      }
      ci_lib.log(
        'flutter_plugin_tools invocation failed; falling back to the '
        'heuristic.',
      );
    } else if (target != null) {
      ci_lib.log(
        'HEAD (${_short(head)}) is not the target commit (${_short(target)}), '
        'so flutter_plugin_tools cannot be used (it always diffs against '
        'HEAD). Using the heuristic instead; check out the commit for an '
        'authoritative answer.',
      );
    }
  }

  // --- Mode 2 -----------------------------------------------------------
  List<String>? files;
  String source;
  if (commit != null) {
    files = hasCheckout ? _filesFromGit(commit, repoRoot) : null;
    source = 'local git';
    if (files == null) {
      files = await _filesFromApi(repo, commit: commit);
      source = 'GitHub API';
    }
  } else {
    files = _filesFromGhPr(pr!, repo);
    source = 'gh';
    if (files == null) {
      files = await _filesFromApi(repo, pr: pr);
      source = 'GitHub API';
    }
  }

  if (files == null) {
    stderr.writeln(
      'Could not determine changed files. Provide --repo-root pointing at a '
      'checkout containing the commit, or install/authenticate `gh`.',
    );
    exit(1);
  }

  final packageFileCounts = <String, int>{};
  final other = <String>[];
  for (final String path in files) {
    final String? package = packageFor(path, hasCheckout ? repoRoot : null);
    if (package != null) {
      packageFileCounts[package] = (packageFileCounts[package] ?? 0) + 1;
    } else {
      other.add(path);
    }
  }
  final List<String> packages = packageFileCounts.keys.toList()..sort();
  final List<String> fullTestFilesList = requiresFullTest(files);
  final List<String> rolls = sdkRolls(files);
  final packageDetection = hasCheckout ? 'pubspec.yaml lookup' : 'path heuristic';
  const mode = 'heuristic (flutter_plugin_tools not applicable)';

  if (json) {
    print(
      jsonEncode(<String, dynamic>{
        'mode': mode,
        'source': source,
        'package_detection': packageDetection,
        'file_count': files.length,
        'packages': packages,
        'non_package_files': other,
        'full_test': fullTestFilesList.isNotEmpty,
        'full_test_files': fullTestFilesList,
        'sdk_rolls': rolls,
      }),
    );
    return;
  }

  print('mode: $mode');
  print(
    'changed files : ${files.length}  (via $source, packages via '
    '$packageDetection)',
  );
  print('changed packages (${packages.length}):');
  for (final package in packages) {
    print('  $package  (${packageFileCounts[package]} file(s))');
  }
  if (packages.isEmpty) {
    print('  (none)');
  }
  if (other.isNotEmpty) {
    print('non-package files (${other.length}):');
    for (final String path in other.take(20)) {
      print('  $path');
    }
    if (other.length > 20) {
      print('  ... and ${other.length - 20} more');
    }
  }

  if (fullTestFilesList.isNotEmpty) {
    print(
      "\nNOTE: ${fullTestFilesList.take(5).join(', ')} matches "
      "flutter_plugin_tools' 'affects the entire repository' rule, so CI runs "
      'against ALL packages.'
      '${rolls.isEmpty ? ' A failure in a package this change never touched is expected noise.' : ''}',
    );
  }

  if (rolls.isNotEmpty) {
    print(rollWarning(rolls));
  }
}
