// Copyright 2013 The Flutter Authors
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:analyze_ci_failure/build_info.dart';
import 'package:analyze_ci_failure/ci_lib.dart' as ci_lib;
import 'package:analyze_ci_failure/failure_analysis.dart';
import 'package:args/args.dart';

const String _searchFields =
    'builds.*.id,builds.*.number,builds.*.status,builds.*.createTime,'
    'builds.*.startTime,builds.*.endTime,builds.*.builder,builds.*.tags';
const Set<String> _badStatus = <String>{'FAILURE', 'INFRA_FAILURE'};
const String _purgedNote = 'log purged';
const String _inaccessibleNote = 'log inaccessible';

/// Notes for builds whose logs couldn't be read, so whether they match is
/// unknown rather than negative.
const Set<String> _unverifiedNotes = <String>{_purgedNote, _inaccessibleNote};

Future<Map<String, dynamic>> _scan({
  required String builder,
  required String bucket,
  required String project,
  required int scanLimit,
  required RegExp? pattern,
  required bool timeoutsOnly,
  required int maxLines,
  required int staleDays,
}) async {
  final List<Map<String, dynamic>> builds = await ci_lib.searchBuilds(
    <String, dynamic>{
      'builder': <String, String>{'project': project, 'bucket': bucket, 'builder': builder},
    },
    fields: _searchFields,
    limit: scanLimit,
  );
  if (builds.isEmpty) {
    stderr.writeln('No builds found for $bucket/$builder in project $project.');
    stderr.writeln('Check the builder name (it is case- and space-sensitive).');
    exit(1);
  }

  final List<Map<String, dynamic>> red = builds
      .where((Map<String, dynamic> b) => _badStatus.contains(b['status']))
      .toList();
  final String oldestDate = buildDate(builds.last);
  final String newestDate = buildDate(builds.first);
  final String? staleWarning = staleBuilderWarning(
    builds.first,
    now: DateTime.now(),
    maxAge: Duration(days: staleDays),
  );
  if (staleWarning != null) {
    ci_lib.log(staleWarning);
  }

  ci_lib.log(
    'Scanned ${builds.length} builds ($oldestDate .. $newestDate); '
    '${red.length} red; fetching logs for those...',
  );

  final results = <Map<String, dynamic>>[];
  for (var i = 0; i < red.length; i++) {
    final Map<String, dynamic> build = red[i];
    if ((i + 1) % 10 == 0) {
      ci_lib.log('  ...${i + 1}/${red.length}');
    }

    final buildId = build['id'] as String;
    final signature = <String>[];
    final packages = <String>{};
    final entry = <String, dynamic>{
      'number': build['number'],
      'id': buildId,
      'date': buildDate(build),
      'status': build['status'],
      'url': ci_lib.miloBuildUrl(project, bucket, builder, build['number'] as int?, buildId),
      'change': buildChange(build).toJson(),
      'matched': null,
    };

    try {
      final Map<String, dynamic> detail = await ci_lib.getBuild(buildId, buildFields);
      final List<Map<String, dynamic>> steps = await analyzeSteps(buildId, detail, maxLines);

      if (steps.isEmpty) {
        entry['note'] = 'no failing step with logs (infra failure?)';
      }

      for (final step in steps) {
        if (step.containsKey('error')) {
          final error = step['error'] as String;
          if (error.contains('purged')) {
            entry['note'] = _purgedNote;
          } else if (error.contains('inaccessible')) {
            entry['note'] = _inaccessibleNote;
          }
          continue;
        }

        if (step['kind'] == 'hung') {
          entry['hung'] = true;
        }

        signature.addAll((step['signature'] as List<dynamic>).cast<String>());
        packages.addAll((step['error_packages'] as List<dynamic>).cast<String>());
        entry['step'] = step['step'];
        entry['log_url'] ??= step['log_url'];

        if (pattern == null || (timeoutsOnly && step['kind'] != 'hung')) {
          continue;
        }
        if (pattern.hasMatch(step['match_text'] as String? ?? '')) {
          entry['matched'] = true;
          entry['log_url'] = step['log_url'];
        }
      }

      final bool unverified = _unverifiedNotes.contains(entry['note']);
      if (entry['matched'] == true && unverified) {
        // Another step's log confirmed the match, so the unreadable one is moot.
        entry.remove('note');
      }
      if (pattern != null && entry['matched'] == null && !unverified) {
        entry['matched'] = false;
      }
    } on Exception catch (e) {
      entry['note'] = 'error: $e';
    }

    entry['signature'] = signature;
    entry['packages'] = packages.toList();
    results.add(entry);
  }

  return <String, dynamic>{
    'builder': builder,
    'bucket': bucket,
    'builder_url': ci_lib.miloBuilderUrl(project, bucket, builder),
    'scanned': builds.length,
    'oldest': oldestDate,
    'newest': newestDate,
    'stale_warning': staleWarning,
    'red': red.length,
    'match': pattern?.pattern,
    'timeouts_only': timeoutsOnly,
    'builds': results,
  };
}

List<Map<String, dynamic>> _builds(Map<String, dynamic> report) =>
    (report['builds'] as List<dynamic>).cast<Map<String, dynamic>>();

void _renderText(Map<String, dynamic> report) {
  final List<Map<String, dynamic>> builds = _builds(report);
  final List<Map<String, dynamic>> matched = builds
      .where((Map<String, dynamic> b) => b['matched'] == true)
      .toList();
  final int purged = builds.where((Map<String, dynamic> b) => b['note'] == _purgedNote).length;
  final int inaccessible = builds
      .where((Map<String, dynamic> b) => b['note'] == _inaccessibleNote)
      .length;
  final int other = builds.where((Map<String, dynamic> b) => b['matched'] == false).length;

  print('builder : ${report['builder']} (${report['bucket']})');
  print(
    'scanned : ${report['scanned']} builds, '
    '${report['oldest']} .. ${report['newest']}',
  );
  print('red     : ${report['red']}');
  if (report['stale_warning'] != null) {
    print(report['stale_warning']);
  }

  if (report['match'] != null) {
    final mode = report['timeouts_only'] == true ? ' (timeouts only)' : '';
    print("match   : '${report['match']}'$mode");
    print(
      '          ${matched.length} matched, $other other failures, '
      '$purged log purged'
      '${inaccessible > 0 ? ', $inaccessible log inaccessible' : ''}',
    );
    if (matched.isNotEmpty) {
      print(
        '          oldest confirmed match: ${matched.last['date']} '
        '(build ${matched.last['number']})',
      );
    }
  }
  print('');

  for (final build in builds) {
    final String flag = switch (build['matched']) {
      true => 'MATCH  ',
      false => 'other  ',
      _ => 'unknown',
    };
    final note = build.containsKey('note') ? '  [${build['note']}]' : '';
    final timeout = build['hung'] == true ? '  TIMEOUT' : '';
    final Object? change = (build['change'] as Map<String, dynamic>)['label'];
    print(
      '$flag ${build['date']}  #${build['number']}  $change'
      '$timeout$note',
    );

    final List<String> packages = (build['packages'] as List<dynamic>).cast<String>();
    if (packages.isNotEmpty) {
      print('         packages: ${packages.join(', ')}');
    }

    final List<String> signature = (build['signature'] as List<dynamic>).cast<String>();
    String? detail;
    if (build['hung'] == true) {
      detail = signature.where((String line) => line.startsWith('last activity:')).lastOrNull;
    } else if (packages.isEmpty) {
      detail = signature.firstOrNull;
    }
    if (detail != null) {
      print('         ${ci_lib.truncate(detail, 150)}');
    }
    print('         ${build['url']}');
  }

  if (report['match'] != null && other > 0) {
    print(
      '\nNOTE: some red builds did NOT match the signature. Inspect them with '
      'summarize_failures.dart -- the builder may have more than one failure '
      'mode.',
    );
  }
}

void _renderMarkdown(Map<String, dynamic> report) {
  final List<Map<String, dynamic>> builds = _builds(report);
  print(
    'Builder: [${report['builder']}](${report['builder_url']}) '
    '(`${report['bucket']}`)\n',
  );
  print(
    'Scanned ${report['scanned']} builds '
    '(${report['oldest']} .. ${report['newest']}); ${report['red']} red.',
  );

  if (report['stale_warning'] != null) {
    print('\n> [!WARNING]\n> ${report['stale_warning']}');
  }

  if (report['match'] != null) {
    final int matched = builds.where((Map<String, dynamic> b) => b['matched'] == true).length;
    print('Signature `${report['match']}` confirmed in **$matched** of them.\n');
  }

  print('| Build | Date | Change | Signature match | Packages | Log |');
  print('| --- | --- | --- | --- | --- | --- |');

  for (final build in builds) {
    String flag = switch (build['matched']) {
      true => 'yes',
      false => 'no (different failure)',
      _ => build['note'] as String? ?? 'unknown',
    };
    if (build['hung'] == true) {
      flag += ' (timeout)';
    }

    final String packages = (build['packages'] as List<dynamic>)
        .map((dynamic p) => '`$p`')
        .join(', ');

    var logUrl = build['log_url'] as String?;
    if (logUrl != null && !logUrl.contains('format=raw')) {
      logUrl = '$logUrl${logUrl.contains('?') ? '&' : '?'}format=raw';
    }
    final link = logUrl != null ? '[raw]($logUrl)' : '—';

    final change = build['change'] as Map<String, dynamic>;
    final Object? changeLink = change['url'] != null
        ? '[${change['label']}](${change['url']})'
        : change['label'];

    print(
      '| [${build['number']}](${build['url']}) | ${build['date']} | $changeLink | $flag | '
      '${packages.isEmpty ? '—' : packages} | $link |',
    );
  }
}

Future<void> main(List<String> args) async {
  final parser = ArgParser()
    ..addOption('builder', help: 'e.g. "Linux_android android_platform_tests_shard_1 stable"')
    ..addOption('bucket', defaultsTo: 'prod', help: 'prod (postsubmit) or try (presubmit).')
    ..addOption('project', defaultsTo: 'flutter')
    ..addOption('scan', defaultsTo: '200', help: 'How many recent builds to walk back through.')
    ..addOption(
      'match',
      help:
          'Regex identifying the failure (see the "suggested:" line of '
          'summarize_failures.dart).',
    )
    ..addFlag(
      'timeouts-only',
      help:
          'Only count builds that timed out with the match near the end of '
          'the cancelled step.',
    )
    ..addOption('max-lines', defaultsTo: '3', help: 'Signature lines to keep per build.')
    ..addOption(
      'stale-days',
      defaultsTo: '14',
      help:
          'Warn that the builder may be renamed or retired if its newest '
          'build is older than this.',
    )
    ..addFlag('markdown', help: 'Emit a markdown table for reports/issues.')
    ..addFlag('json', help: 'Output as JSON.');

  final ArgResults parsedArgs;
  final int scanLimit;
  final int maxLines;
  final int staleDays;
  final RegExp? pattern;
  try {
    parsedArgs = parser.parse(args);
    if (parsedArgs['builder'] == null) {
      throw const FormatException('Must specify --builder');
    }
    scanLimit = int.parse(parsedArgs['scan'] as String);
    maxLines = int.parse(parsedArgs['max-lines'] as String);
    staleDays = int.parse(parsedArgs['stale-days'] as String);
    final match = parsedArgs['match'] as String?;
    pattern = match == null ? null : RegExp(match);
  } on FormatException catch (e) {
    stderr.writeln('Error: ${e.message}');
    stderr.writeln(parser.usage);
    exit(1);
  }

  final Map<String, dynamic> report = await _scan(
    builder: parsedArgs['builder'] as String,
    bucket: parsedArgs['bucket'] as String,
    project: parsedArgs['project'] as String,
    scanLimit: scanLimit,
    pattern: pattern,
    timeoutsOnly: parsedArgs['timeouts-only'] as bool,
    maxLines: maxLines,
    staleDays: staleDays,
  );

  if (parsedArgs['json'] as bool) {
    print(jsonEncode(report));
  } else if (parsedArgs['markdown'] as bool) {
    _renderMarkdown(report);
  } else {
    _renderText(report);
  }
}
