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
});

enum _Basename {
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

  const _Basename(this.name);

  final String name;

  _TypescaleValues get typescaleValues => switch (this) {
    _Basename.displayLarge => (
      fontSize: TokenTypescale.displayLargeFontSize,
      fontWeight: TokenTypescale.displayLargeFontWeight,
      lineHeight: TokenTypescale.displayLargeLineHeight,
      letterSpacing: TokenTypescale.displayLargeLetterSpacing,
    ),
    _Basename.displayMedium => (
      fontSize: TokenTypescale.displayMediumFontSize,
      fontWeight: TokenTypescale.displayMediumFontWeight,
      lineHeight: TokenTypescale.displayMediumLineHeight,
      letterSpacing: TokenTypescale.displayMediumLetterSpacing,
    ),
    _Basename.displaySmall => (
      fontSize: TokenTypescale.displaySmallFontSize,
      fontWeight: TokenTypescale.displaySmallFontWeight,
      lineHeight: TokenTypescale.displaySmallLineHeight,
      letterSpacing: TokenTypescale.displaySmallLetterSpacing,
    ),
    _Basename.headlineLarge => (
      fontSize: TokenTypescale.headlineLargeFontSize,
      fontWeight: TokenTypescale.headlineLargeFontWeight,
      lineHeight: TokenTypescale.headlineLargeLineHeight,
      letterSpacing: TokenTypescale.headlineLargeLetterSpacing,
    ),
    _Basename.headlineMedium => (
      fontSize: TokenTypescale.headlineMediumFontSize,
      fontWeight: TokenTypescale.headlineMediumFontWeight,
      lineHeight: TokenTypescale.headlineMediumLineHeight,
      letterSpacing: TokenTypescale.headlineMediumLetterSpacing,
    ),
    _Basename.headlineSmall => (
      fontSize: TokenTypescale.headlineSmallFontSize,
      fontWeight: TokenTypescale.headlineSmallFontWeight,
      lineHeight: TokenTypescale.headlineSmallLineHeight,
      letterSpacing: TokenTypescale.headlineSmallLetterSpacing,
    ),
    _Basename.titleLarge => (
      fontSize: TokenTypescale.titleLargeFontSize,
      fontWeight: TokenTypescale.titleLargeFontWeight,
      lineHeight: TokenTypescale.titleLargeLineHeight,
      letterSpacing: TokenTypescale.titleLargeLetterSpacing,
    ),
    _Basename.titleMedium => (
      fontSize: TokenTypescale.titleMediumFontSize,
      fontWeight: TokenTypescale.titleMediumFontWeight,
      lineHeight: TokenTypescale.titleMediumLineHeight,
      letterSpacing: TokenTypescale.titleMediumLetterSpacing,
    ),
    _Basename.titleSmall => (
      fontSize: TokenTypescale.titleSmallFontSize,
      fontWeight: TokenTypescale.titleSmallFontWeight,
      lineHeight: TokenTypescale.titleSmallLineHeight,
      letterSpacing: TokenTypescale.titleSmallLetterSpacing,
    ),
    _Basename.labelLarge => (
      fontSize: TokenTypescale.labelLargeFontSize,
      fontWeight: TokenTypescale.labelLargeFontWeight,
      lineHeight: TokenTypescale.labelLargeLineHeight,
      letterSpacing: TokenTypescale.labelLargeLetterSpacing,
    ),
    _Basename.labelMedium => (
      fontSize: TokenTypescale.labelMediumFontSize,
      fontWeight: TokenTypescale.labelMediumFontWeight,
      lineHeight: TokenTypescale.labelMediumLineHeight,
      letterSpacing: TokenTypescale.labelMediumLetterSpacing,
    ),
    _Basename.labelSmall => (
      fontSize: TokenTypescale.labelSmallFontSize,
      fontWeight: TokenTypescale.labelSmallFontWeight,
      lineHeight: TokenTypescale.labelSmallLineHeight,
      letterSpacing: TokenTypescale.labelSmallLetterSpacing,
    ),
    _Basename.bodyLarge => (
      fontSize: TokenTypescale.bodyLargeFontSize,
      fontWeight: TokenTypescale.bodyLargeFontWeight,
      lineHeight: TokenTypescale.bodyLargeLineHeight,
      letterSpacing: TokenTypescale.bodyLargeLetterSpacing,
    ),
    _Basename.bodyMedium => (
      fontSize: TokenTypescale.bodyMediumFontSize,
      fontWeight: TokenTypescale.bodyMediumFontWeight,
      lineHeight: TokenTypescale.bodyMediumLineHeight,
      letterSpacing: TokenTypescale.bodyMediumLetterSpacing,
    ),
    _Basename.bodySmall => (
      fontSize: TokenTypescale.bodySmallFontSize,
      fontWeight: TokenTypescale.bodySmallFontWeight,
      lineHeight: TokenTypescale.bodySmallLineHeight,
      letterSpacing: TokenTypescale.bodySmallLetterSpacing,
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
  ${_textTheme('englishLike', 'alphabetic')}

  ${_textTheme('dense', 'ideographic')}

  ${_textTheme('tall', 'alphabetic')}
}
''';
  }

  String _textTheme(String name, String baseline) {
    final theme = StringBuffer('static const TextTheme $name = TextTheme(\n');
    for (final _Basename basename in _Basename.values) {
      theme.writeln(_textStyleDef(basename: basename, name: name, baseline: baseline));
    }
    theme.write('  );');
    return theme.toString();
  }

  String _textStyleDef({
    required _Basename basename,
    required String name,
    required String baseline,
  }) {
    final (
      fontSize: double fontSize,
      fontWeight: double fontWeight,
      lineHeight: double lineHeight,
      letterSpacing: double letterSpacing,
    ) = basename.typescaleValues;
    final String fontHeight = (lineHeight / fontSize).toStringAsFixed(2);

    final String baseName = basename.name;
    final style = StringBuffer("    $baseName: TextStyle(debugLabel: '$name $baseName 2026'");
    style.write(', inherit: false');
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
