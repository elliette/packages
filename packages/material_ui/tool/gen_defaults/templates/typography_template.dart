// Copyright 2013 The Flutter Authors
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '../data/typescale.dart';
import 'template.dart';

typedef _TypescaleValues = ({
  double fontSize,
  double fontWeight,
  double lineHeight,
  double letterSpacing,
  String fontFamily,
});

enum _TypeStyle {
  displayLarge('displayLarge'),
  displayMedium('displayMedium'),
  displaySmall('displaySmall'),
  headlineLarge('headlineLarge'),
  headlineMedium('headlineMedium'),
  headlineSmall('headlineSmall'),
  titleLarge('titleLarge'),
  titleMedium('titleMedium'),
  titleSmall('titleSmall'),
  labelLarge('labelLarge'),
  labelMedium('labelMedium'),
  labelSmall('labelSmall'),
  bodyLarge('bodyLarge'),
  bodyMedium('bodyMedium'),
  bodySmall('bodySmall');

  const _TypeStyle(this.name);

  final String name;

  _TypescaleValues get typescaleValues => switch (this) {
    _TypeStyle.displayLarge => (
      fontSize: TokenTypescale.displayLargeFontSize,
      fontWeight: TokenTypescale.displayLargeFontWeight,
      lineHeight: TokenTypescale.displayLargeLineHeight,
      letterSpacing: TokenTypescale.displayLargeLetterSpacing,
      fontFamily: TokenTypescale.displayLargeFontFamily,
    ),
    _TypeStyle.displayMedium => (
      fontSize: TokenTypescale.displayMediumFontSize,
      fontWeight: TokenTypescale.displayMediumFontWeight,
      lineHeight: TokenTypescale.displayMediumLineHeight,
      letterSpacing: TokenTypescale.displayMediumLetterSpacing,
      fontFamily: TokenTypescale.displayMediumFontFamily,
    ),
    _TypeStyle.displaySmall => (
      fontSize: TokenTypescale.displaySmallFontSize,
      fontWeight: TokenTypescale.displaySmallFontWeight,
      lineHeight: TokenTypescale.displaySmallLineHeight,
      letterSpacing: TokenTypescale.displaySmallLetterSpacing,
      fontFamily: TokenTypescale.displaySmallFontFamily,
    ),
    _TypeStyle.headlineLarge => (
      fontSize: TokenTypescale.headlineLargeFontSize,
      fontWeight: TokenTypescale.headlineLargeFontWeight,
      lineHeight: TokenTypescale.headlineLargeLineHeight,
      letterSpacing: TokenTypescale.headlineLargeLetterSpacing,
      fontFamily: TokenTypescale.headlineLargeFontFamily,
    ),
    _TypeStyle.headlineMedium => (
      fontSize: TokenTypescale.headlineMediumFontSize,
      fontWeight: TokenTypescale.headlineMediumFontWeight,
      lineHeight: TokenTypescale.headlineMediumLineHeight,
      letterSpacing: TokenTypescale.headlineMediumLetterSpacing,
      fontFamily: TokenTypescale.headlineMediumFontFamily,
    ),
    _TypeStyle.headlineSmall => (
      fontSize: TokenTypescale.headlineSmallFontSize,
      fontWeight: TokenTypescale.headlineSmallFontWeight,
      lineHeight: TokenTypescale.headlineSmallLineHeight,
      letterSpacing: TokenTypescale.headlineSmallLetterSpacing,
      fontFamily: TokenTypescale.headlineSmallFontFamily,
    ),
    _TypeStyle.titleLarge => (
      fontSize: TokenTypescale.titleLargeFontSize,
      fontWeight: TokenTypescale.titleLargeFontWeight,
      lineHeight: TokenTypescale.titleLargeLineHeight,
      letterSpacing: TokenTypescale.titleLargeLetterSpacing,
      fontFamily: TokenTypescale.titleLargeFontFamily,
    ),
    _TypeStyle.titleMedium => (
      fontSize: TokenTypescale.titleMediumFontSize,
      fontWeight: TokenTypescale.titleMediumFontWeight,
      lineHeight: TokenTypescale.titleMediumLineHeight,
      letterSpacing: TokenTypescale.titleMediumLetterSpacing,
      fontFamily: TokenTypescale.titleMediumFontFamily,
    ),
    _TypeStyle.titleSmall => (
      fontSize: TokenTypescale.titleSmallFontSize,
      fontWeight: TokenTypescale.titleSmallFontWeight,
      lineHeight: TokenTypescale.titleSmallLineHeight,
      letterSpacing: TokenTypescale.titleSmallLetterSpacing,
      fontFamily: TokenTypescale.titleSmallFontFamily,
    ),
    _TypeStyle.labelLarge => (
      fontSize: TokenTypescale.labelLargeFontSize,
      fontWeight: TokenTypescale.labelLargeFontWeight,
      lineHeight: TokenTypescale.labelLargeLineHeight,
      letterSpacing: TokenTypescale.labelLargeLetterSpacing,
      fontFamily: TokenTypescale.labelLargeFontFamily,
    ),
    _TypeStyle.labelMedium => (
      fontSize: TokenTypescale.labelMediumFontSize,
      fontWeight: TokenTypescale.labelMediumFontWeight,
      lineHeight: TokenTypescale.labelMediumLineHeight,
      letterSpacing: TokenTypescale.labelMediumLetterSpacing,
      fontFamily: TokenTypescale.labelMediumFontFamily,
    ),
    _TypeStyle.labelSmall => (
      fontSize: TokenTypescale.labelSmallFontSize,
      fontWeight: TokenTypescale.labelSmallFontWeight,
      lineHeight: TokenTypescale.labelSmallLineHeight,
      letterSpacing: TokenTypescale.labelSmallLetterSpacing,
      fontFamily: TokenTypescale.labelSmallFontFamily,
    ),
    _TypeStyle.bodyLarge => (
      fontSize: TokenTypescale.bodyLargeFontSize,
      fontWeight: TokenTypescale.bodyLargeFontWeight,
      lineHeight: TokenTypescale.bodyLargeLineHeight,
      letterSpacing: TokenTypescale.bodyLargeLetterSpacing,
      fontFamily: TokenTypescale.bodyLargeFontFamily,
    ),
    _TypeStyle.bodyMedium => (
      fontSize: TokenTypescale.bodyMediumFontSize,
      fontWeight: TokenTypescale.bodyMediumFontWeight,
      lineHeight: TokenTypescale.bodyMediumLineHeight,
      letterSpacing: TokenTypescale.bodyMediumLetterSpacing,
      fontFamily: TokenTypescale.bodyMediumFontFamily,
    ),
    _TypeStyle.bodySmall => (
      fontSize: TokenTypescale.bodySmallFontSize,
      fontWeight: TokenTypescale.bodySmallFontWeight,
      lineHeight: TokenTypescale.bodySmallLineHeight,
      letterSpacing: TokenTypescale.bodySmallLetterSpacing,
      fontFamily: TokenTypescale.bodySmallFontFamily,
    ),
  };
}

class TypographyTemplate extends M3TokenTemplate {
  const TypographyTemplate();

  @override
  String get name => 'typography';

  @override
  String generateContents() {
    return '''
abstract final class _M3Typography {
  // Defines text geometry for `ScriptCategory.englishLike` scripts, such as
  // English, French, Russian, etc.
  ${_textTheme('englishLike', 'alphabetic')}
  // Defines text geometry for dense scripts, such as Chinese, Japanese
  // and Korean.
  ${_textTheme('dense', 'ideographic')}
  // Defines text geometry for tall scripts, such as Farsi, Hindi, and Thai.
  ${_textTheme('tall', 'alphabetic')}
}
''';
  }

  String _textTheme(String name, String baseline) {
    final theme = StringBuffer('static const TextTheme $name = TextTheme(\n');
    for (final _TypeStyle typeStyle in _TypeStyle.values) {
      theme.writeln(_textStyleDef(typeStyle: typeStyle, name: name, baseline: baseline));
    }
    theme.write('  );');
    return theme.toString();
  }

  String _textStyleDef({
    required _TypeStyle typeStyle,
    required String name,
    required String baseline,
  }) {
    final (
      fontSize: double fontSize,
      fontWeight: double fontWeight,
      lineHeight: double lineHeight,
      letterSpacing: double letterSpacing,
      fontFamily: String fontFamily,
    ) = typeStyle.typescaleValues;
    final String fontHeight = (lineHeight / fontSize).toStringAsFixed(2);

    final String baseName = typeStyle.name;
    final style = StringBuffer("    $baseName: TextStyle(debugLabel: '$name $baseName 2026'");
    style.write(', inherit: false');
    style.write(", fontFamily: '$fontFamily'");
    style.write(', fontSize: $fontSize');
    style.write(', fontWeight: FontWeight.w${fontWeight.toInt()}');
    style.write(', letterSpacing: $letterSpacing');
    style.write(', height: $fontHeight');
    style.write(', textBaseline: TextBaseline.$baseline');
    style.write(', leadingDistribution: TextLeadingDistribution.even');
    style.write('),');
    return style.toString();
  }
}
