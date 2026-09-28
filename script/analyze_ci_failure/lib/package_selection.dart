// Copyright 2013 The Flutter Authors
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// Heuristic reconstruction of flutter_plugin_tools' changed-package
/// selection, used when the tool itself can't be run.
library;

import 'dart:io';

import 'package:path/path.dart' as p;

/// Mirror of `PackageCommand._changesRequireFullTest` in
/// script/tool/lib/src/common/package_command.dart. Re-check it against that
/// function if results look wrong.
const List<String> fullTestFiles = <String>['.ci.yaml', '.clang-format', 'analysis_options.yaml'];

/// Directories whose contents trigger a full test; see [fullTestFiles].
const List<String> fullTestDirs = <String>['.ci/', 'script/'];

/// Directories that live *inside* a package; if one of these is the third path
/// segment then the package is `packages/<name>`, not
/// `packages/<group>/<name>`.
const Set<String> packageInternalDirs = <String>{
  'lib',
  'test',
  'example',
  'android',
  'ios',
  'macos',
  'linux',
  'windows',
  'web',
  'darwin',
  'pigeons',
  'tool',
  'bin',
  'doc',
  'docs',
  'integration_test',
  'test_driver',
  'images',
  'assets',
  'scripts',
};

/// The phrase flutter_plugin_tools prints when it selects every package.
const String fullTestMessage = 'could affect the entire repository';

/// Returns the package directory containing repo-relative [path], or null if
/// it isn't in a package.
///
/// When [repoRoot] is given, a package is identified by its `pubspec.yaml`;
/// otherwise the directory layout is guessed.
String? packageFor(String path, String? repoRoot) {
  final List<String> parts = path.split('/');
  var prefix = '';
  var packageParts = parts;

  if (parts.length > 1 && parts[0] == 'third_party') {
    prefix = 'third_party/';
    packageParts = parts.sublist(1);
  }

  if (packageParts.length < 2 || packageParts[0] != 'packages') {
    return null;
  }

  final one = '${prefix}packages/${packageParts[1]}';
  // `packages/<name>/<file>`: the third segment is a file, not a sub-package.
  if (packageParts.length < 4) {
    return one;
  }
  final two = '$one/${packageParts[2]}';

  if (repoRoot != null) {
    if (File(p.join(repoRoot, two, 'pubspec.yaml')).existsSync()) {
      return two;
    }
    if (File(p.join(repoRoot, one, 'pubspec.yaml')).existsSync()) {
      return one;
    }
  }

  return packageInternalDirs.contains(packageParts[2]) ? one : two;
}

/// The subset of [files] that make flutter_plugin_tools test every package.
List<String> requiresFullTest(List<String> files) {
  return files
      .where(
        (String path) =>
            fullTestFiles.contains(path) || fullTestDirs.any((String dir) => path.startsWith(dir)),
      )
      .toList();
}

/// CI pins each channel's Flutter SDK via `version_file:` in .ci.yaml.
final RegExp _sdkPin = RegExp(r'^\.ci/flutter_(\w+)\.version$');

/// Channels whose pinned Flutter SDK [files] moves (e.g. `['master']`).
List<String> sdkRolls(List<String> files) {
  final channels = <String>{for (final String path in files) ?_sdkPin.firstMatch(path)?.group(1)};
  return channels.toList()..sort();
}

/// Explains how to interpret failures on a PR that rolls [channels].
String rollWarning(List<String> channels) {
  final String rolled = channels.join('/');
  final List<String> unaffected = <String>{'master', 'stable'}.difference(channels.toSet()).toList()
    ..sort();

  final buffer = StringBuffer()
    ..writeln()
    ..writeln('WARNING: this is a Flutter SDK roll ($rolled). The all-packages rule applies, but')
    ..writeln(
      "the 'untouched package => noise' conclusion does NOT: a new SDK can break any package.",
    )
    ..write(
      "  * Failures on '$rolled' builders MAY be caused by this change -> prove them flaky in step 4.",
    );
  if (unaffected.isNotEmpty) {
    buffer
      ..writeln()
      ..write(
        "  * Failures on '${unaffected.join('/')}' builders run the old SDK and cannot be caused by it.",
      );
  }
  return buffer.toString();
}
