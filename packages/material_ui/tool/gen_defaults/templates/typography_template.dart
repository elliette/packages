// Copyright 2013 The Flutter Authors
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '../data/typescale.dart';
import '../data/typescale_struct.dart';
import 'template.dart';

class TypographyTemplateM3 extends TokenTemplateM3 {
  const TypographyTemplateM3();

  static const List<TypescaleStruct> _typescales = <TypescaleStruct>[
    TokenTypescale.displayLarge,
    TokenTypescale.displayMedium,
    TokenTypescale.displaySmall,
    TokenTypescale.headlineLarge,
    TokenTypescale.headlineMedium,
    TokenTypescale.headlineSmall,
    TokenTypescale.titleLarge,
    TokenTypescale.titleMedium,
    TokenTypescale.titleSmall,
    TokenTypescale.labelLarge,
    TokenTypescale.labelMedium,
    TokenTypescale.labelSmall,
    TokenTypescale.bodyLarge,
    TokenTypescale.bodyMedium,
    TokenTypescale.bodySmall,
  ];

  @override
  String get name => 'Typography';

  @override
  String get parentFilePath => 'typography.dart';

  @override
  String generateContents(String className) =>
      '''
abstract final class $className {
  ${_textTheme('englishLike', 'alphabetic')}

  ${_textTheme('dense', 'ideographic')}

  ${_textTheme('tall', 'alphabetic')}
}
''';

  String _textTheme(String name, String baseline) {
    final theme = StringBuffer('static const TextTheme $name = TextTheme(\n');
    for (final TypescaleStruct typescale in _typescales) {
      final String typeName = formatTypeName(typescale.name);
      theme.writeln(
        '    $typeName: ${_textStyleDef(typescale, '$name $typeName 2021', baseline)},',
      );
    }
    theme.write('  );');
    return theme.toString();
  }

  String _textStyleDef(TypescaleStruct typescale, String debugLabel, String baseline) {
    final style = StringBuffer("TextStyle(debugLabel: '$debugLabel'");
    style.write(', inherit: false');
    style.write(', fontSize: ${_fontSize(typescale)}');
    style.write(', fontWeight: ${_fontWeight(typescale)}');
    style.write(', letterSpacing: ${_fontSpacing(typescale)}');
    style.write(', height: ${_fontHeight(typescale)}');
    style.write(', textBaseline: TextBaseline.$baseline');
    style.write(', leadingDistribution: TextLeadingDistribution.even');
    style.write(')');
    return style.toString();
  }

  String _fontSize(TypescaleStruct typescale) => number(typescale.fontSize);

  String _fontWeight(TypescaleStruct typescale) => 'FontWeight.w${typescale.fontWeight.toInt()}';

  String _fontSpacing(TypescaleStruct typescale) => number(typescale.letterSpacing);

  String _fontHeight(TypescaleStruct typescale) =>
      (typescale.lineHeight / typescale.fontSize).toStringAsFixed(2);
}
