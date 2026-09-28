// Copyright 2013 The Flutter Authors
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:analyze_ci_failure/package_selection.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  group('packageFor', () {
    test('returns null outside packages', () {
      expect(packageFor('script/tool/lib/main.dart', null), isNull);
      expect(packageFor('README.md', null), isNull);
      expect(packageFor('third_party/README.md', null), isNull);
    });

    test('guesses single-level packages', () {
      expect(packageFor('packages/pigeon/lib/pigeon.dart', null), 'packages/pigeon');
      expect(packageFor('packages/pigeon/pubspec.yaml', null), 'packages/pigeon');
      expect(packageFor('packages/pigeon/CHANGELOG.md', null), 'packages/pigeon');
    });

    test('guesses federated packages', () {
      expect(
        packageFor('packages/camera/camera_android/lib/a.dart', null),
        'packages/camera/camera_android',
      );
    });

    test('handles third_party', () {
      expect(
        packageFor('third_party/packages/flutter_svg/lib/svg.dart', null),
        'third_party/packages/flutter_svg',
      );
    });

    group('with a repo root', () {
      late Directory root;

      setUp(() {
        root = Directory.systemTemp.createTempSync('package_for_test');
      });

      tearDown(() {
        root.deleteSync(recursive: true);
      });

      test('prefers the directory with a pubspec.yaml', () {
        // `generated` isn't a known internal directory, so the heuristic alone
        // would wrongly treat it as a federated sub-package.
        File(p.join(root.path, 'packages', 'foo', 'pubspec.yaml'))
          ..createSync(recursive: true)
          ..writeAsStringSync('name: foo');

        expect(packageFor('packages/foo/generated/a.dart', root.path), 'packages/foo');
        expect(packageFor('packages/foo/generated/a.dart', null), 'packages/foo/generated');
      });
    });
  });

  group('requiresFullTest', () {
    test('matches special files and directories only', () {
      expect(
        requiresFullTest(<String>[
          '.ci.yaml',
          '.ci/flutter_master.version',
          'script/tool/lib/main.dart',
          'analysis_options.yaml',
          'packages/foo/analysis_options.yaml',
          'packages/foo/lib/foo.dart',
        ]),
        <String>[
          '.ci.yaml',
          '.ci/flutter_master.version',
          'script/tool/lib/main.dart',
          'analysis_options.yaml',
        ],
      );
    });
  });

  group('sdkRolls', () {
    test('finds rolled channels, sorted and deduplicated', () {
      expect(
        sdkRolls(<String>[
          '.ci/flutter_stable.version',
          '.ci/flutter_master.version',
          '.ci/flutter_master.version',
          '.ci/other.version',
        ]),
        <String>['master', 'stable'],
      );
    });
  });

  group('rollWarning', () {
    test('names the unaffected channel', () {
      final String warning = rollWarning(<String>['master']);
      expect(warning, contains("Failures on 'master' builders MAY"));
      expect(warning, contains("Failures on 'stable' builders run the old SDK"));
    });

    test('omits the unaffected line when both channels roll', () {
      expect(rollWarning(<String>['master', 'stable']), isNot(contains('old SDK')));
    });
  });
}
