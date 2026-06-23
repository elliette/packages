// Copyright 2013 The Flutter Authors
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
//
// ## Usage
//
// Run from the root of flutter/packages:
//
// ```
// dart packages/material_ui/tool/gen_defaults/bin/gen_defaults.dart [-v]
// ```

import 'package:args/args.dart';

import '../templates/action_chip_m3_template.dart';

Future<void> main(List<String> args) async {
  // Parse arguments
  final parser = ArgParser();
  parser.addFlag('verbose', abbr: 'v', help: 'Enable verbose output', negatable: false);
  final ArgResults argResults = parser.parse(args);
  final verbose = argResults['verbose'] as bool;

  const M3ActionChipTemplate().generateFile(verbose: verbose);
}
