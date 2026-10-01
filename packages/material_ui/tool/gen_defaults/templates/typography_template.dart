// Copyright 2013 The Flutter Authors
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '../data/typescale.dart';
import '../data/typescale_emphasized.dart';
import '../data/typescale_struct.dart';
import 'template.dart';

const List<(String, TypescaleStruct)> _baselineTextStyles = <(String, TypescaleStruct)>[
  ('displayLarge', TokenTypescale.displayLarge),
  ('displayMedium', TokenTypescale.displayMedium),
  ('displaySmall', TokenTypescale.displaySmall),
  ('headlineLarge', TokenTypescale.headlineLarge),
  ('headlineMedium', TokenTypescale.headlineMedium),
  ('headlineSmall', TokenTypescale.headlineSmall),
  ('titleLarge', TokenTypescale.titleLarge),
  ('titleMedium', TokenTypescale.titleMedium),
  ('titleSmall', TokenTypescale.titleSmall),
  ('labelLarge', TokenTypescale.labelLarge),
  ('labelMedium', TokenTypescale.labelMedium),
  ('labelSmall', TokenTypescale.labelSmall),
  ('bodyLarge', TokenTypescale.bodyLarge),
  ('bodyMedium', TokenTypescale.bodyMedium),
  ('bodySmall', TokenTypescale.bodySmall),
];

const List<(String, TypescaleStruct)> _emphasizedTextStyles = <(String, TypescaleStruct)>[
  ('displayLargeEmphasized', TokenTypescaleEmphasized.displayLarge),
  ('displayMediumEmphasized', TokenTypescaleEmphasized.displayMedium),
  ('displaySmallEmphasized', TokenTypescaleEmphasized.displaySmall),
  ('headlineLargeEmphasized', TokenTypescaleEmphasized.headlineLarge),
  ('headlineMediumEmphasized', TokenTypescaleEmphasized.headlineMedium),
  ('headlineSmallEmphasized', TokenTypescaleEmphasized.headlineSmall),
  ('titleLargeEmphasized', TokenTypescaleEmphasized.titleLarge),
  ('titleMediumEmphasized', TokenTypescaleEmphasized.titleMedium),
  ('titleSmallEmphasized', TokenTypescaleEmphasized.titleSmall),
  ('labelLargeEmphasized', TokenTypescaleEmphasized.labelLarge),
  ('labelMediumEmphasized', TokenTypescaleEmphasized.labelMedium),
  ('labelSmallEmphasized', TokenTypescaleEmphasized.labelSmall),
  ('bodyLargeEmphasized', TokenTypescaleEmphasized.bodyLarge),
  ('bodyMediumEmphasized', TokenTypescaleEmphasized.bodyMedium),
  ('bodySmallEmphasized', TokenTypescaleEmphasized.bodySmall),
];

String _textTheme(
  String Function(num) number, {
  required String name,
  required String baseline,
  required String year,
  required List<(String, TypescaleStruct)> styles,
}) {
  final theme = StringBuffer('static const TextTheme $name = TextTheme(\n');
  for (final (String styleName, TypescaleStruct token) in styles) {
    theme.writeln(
      '    $styleName: ${_textStyleDef(number, token, '$name $styleName $year', baseline)},',
    );
  }
  theme.write('  );');
  return theme.toString();
}

String _textStyleDef(
  String Function(num) number,
  TypescaleStruct token,
  String debugLabel,
  String baseline,
) {
  final style = StringBuffer("TextStyle(debugLabel: '$debugLabel'");
  style.write(', inherit: false');
  style.write(', fontSize: ${number(token.fontSize)}');
  style.write(', fontWeight: FontWeight.w${token.fontWeight.toInt()}');
  style.write(', letterSpacing: ${number(token.letterSpacing)}');
  style.write(', height: ${(token.lineHeight / token.fontSize).toStringAsFixed(2)}');
  style.write(', textBaseline: TextBaseline.$baseline');
  style.write(', leadingDistribution: TextLeadingDistribution.even');
  style.write(')');
  return style.toString();
}

class TypographyTemplateM3 extends TokenTemplateM3 {
  const TypographyTemplateM3();

  @override
  String get name => 'Typography';

  @override
  String get parentFilePath => 'typography.dart';

  @override
  String get className => '_M3Typography';

  @override
  String generateContents(String className) =>
      '''
abstract final class $className {
  ${_m3TextTheme('englishLike', 'alphabetic')}

  ${_m3TextTheme('dense', 'ideographic')}

  ${_m3TextTheme('tall', 'alphabetic')}
}
''';

  String _m3TextTheme(String name, String baseline) =>
      _textTheme(number, name: name, baseline: baseline, year: '2021', styles: _baselineTextStyles);
}

/// Generates the Material 3 Expressive typography geometry.
///
/// Unlike [TypographyTemplateM3], only `alphabetic` and `ideographic` text
/// themes are generated, since in Material 3 onwards tall and English-like
/// scripts share identical geometry and dense scripts differ only in their
/// text baseline. Each text theme also includes the emphasized type styles.
class TypographyTemplateM3E extends TokenTemplateM3E {
  const TypographyTemplateM3E();

  @override
  String get name => 'Typography';

  @override
  String get parentFilePath => 'typography.dart';

  @override
  String get className => '_M3ETypography';

  @override
  String generateContents(String className) =>
      '''
abstract final class $className {
  ${_m3eTextTheme('alphabetic', 'alphabetic')}

  ${_m3eTextTheme('ideographic', 'ideographic')}
}
''';

  String _m3eTextTheme(String name, String baseline) => _textTheme(
    number,
    name: name,
    baseline: baseline,
    year: '2026',
    styles: <(String, TypescaleStruct)>[..._baselineTextStyles, ..._emphasizedTextStyles],
  );
}
