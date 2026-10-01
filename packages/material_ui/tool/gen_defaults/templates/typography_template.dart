// Copyright 2013 The Flutter Authors
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '../data/typescale.dart';
import '../data/typescale_struct.dart';
import 'template.dart';

class TypographyTemplateM3 extends TokenTemplateM3 {
  const TypographyTemplateM3();

  @override
  String get name => 'Typography';

  @override
  String get parentFilePath => 'typography.dart';

  @override
  String get className => '_M3Typography';

  static const List<(String, TypescaleStruct)> _textStyles = <(String, TypescaleStruct)>[
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
    for (final (String styleName, TypescaleStruct token) in _textStyles) {
      theme.writeln('    $styleName: ${_textStyleDef(token, '$name $styleName 2021', baseline)},');
    }
    theme.write('  );');
    return theme.toString();
  }

  String _textStyleDef(TypescaleStruct token, String debugLabel, String baseline) {
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
}
