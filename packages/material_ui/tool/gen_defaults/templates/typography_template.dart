// Copyright 2013 The Flutter Authors
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '../data/typescale.dart';
import '../data/typescale_emphasized.dart';
import '../data/typescale_struct.dart';
import 'template.dart';

class TypographyTemplate extends M3TokenTemplate {
  const TypographyTemplate();

  @override
  String get name => 'typography';

  @override
  String generateContents() {
    return '''
abstract final class _M3ETypography {
  // Defines text geometry for alphabetic scripts (`ScriptCategory.englishLike`
  // and `ScriptCategory.tall`), such as English, French, Russian, Farsi, Hindi,
  // Thai, etc.
  ${_textTheme(_ScriptType.alphabetic)}
  // Defines text geometry for ideographic scripts (`ScriptCategory.dense`),
  // such as Chinese, Japanese, and Korean.
  ${_textTheme(_ScriptType.ideographic)}
}
''';
  }

  String _textTheme(_ScriptType scriptType) {
    final themeDef = StringBuffer('static const TextTheme ${scriptType.name} = TextTheme(\n');
    for (final _Typescale typescale in _Typescale.values) {
      themeDef.writeln(_textStyleDef(typescale: typescale, scriptType: scriptType));
    }
    themeDef.write('  );');
    return themeDef.toString();
  }

  String _textStyleDef({required _Typescale typescale, required _ScriptType scriptType}) {
    final TypescaleStruct struct = typescale.struct;
    final String typeName = typescale.name;
    final String scriptName = scriptType.name;
    final double fontSize = struct.fontSize;
    final double lineHeight = struct.lineHeight;
    final String fontHeight = (lineHeight / fontSize).toStringAsFixed(2);

    final style = StringBuffer("    $typeName: TextStyle(debugLabel: '$scriptName $typeName 2026'");
    style.write(', inherit: false');
    style.write(', fontSize: $fontSize');
    style.write(', fontWeight: FontWeight.w${struct.fontWeight.toInt()}');
    style.write(', letterSpacing: ${struct.letterSpacing}');
    style.write(', height: $fontHeight');
    style.write(', textBaseline: TextBaseline.$scriptName');
    style.write(', leadingDistribution: TextLeadingDistribution.even');
    style.write('),');
    return style.toString();
  }
}

enum _ScriptType { alphabetic, ideographic }

enum _Typescale {
  displayLarge(TokenTypescale.displayLarge),
  displayMedium(TokenTypescale.displayMedium),
  displaySmall(TokenTypescale.displaySmall),
  headlineLarge(TokenTypescale.headlineLarge),
  headlineMedium(TokenTypescale.headlineMedium),
  headlineSmall(TokenTypescale.headlineSmall),
  titleLarge(TokenTypescale.titleLarge),
  titleMedium(TokenTypescale.titleMedium),
  titleSmall(TokenTypescale.titleSmall),
  labelLarge(TokenTypescale.labelLarge),
  labelMedium(TokenTypescale.labelMedium),
  labelSmall(TokenTypescale.labelSmall),
  bodyLarge(TokenTypescale.bodyLarge),
  bodyMedium(TokenTypescale.bodyMedium),
  bodySmall(TokenTypescale.bodySmall),
  displayLargeEmphasized(TokenTypescaleEmphasized.displayLarge),
  displayMediumEmphasized(TokenTypescaleEmphasized.displayMedium),
  displaySmallEmphasized(TokenTypescaleEmphasized.displaySmall),
  headlineLargeEmphasized(TokenTypescaleEmphasized.headlineLarge),
  headlineMediumEmphasized(TokenTypescaleEmphasized.headlineMedium),
  headlineSmallEmphasized(TokenTypescaleEmphasized.headlineSmall),
  titleLargeEmphasized(TokenTypescaleEmphasized.titleLarge),
  titleMediumEmphasized(TokenTypescaleEmphasized.titleMedium),
  titleSmallEmphasized(TokenTypescaleEmphasized.titleSmall),
  labelLargeEmphasized(TokenTypescaleEmphasized.labelLarge),
  labelMediumEmphasized(TokenTypescaleEmphasized.labelMedium),
  labelSmallEmphasized(TokenTypescaleEmphasized.labelSmall),
  bodyLargeEmphasized(TokenTypescaleEmphasized.bodyLarge),
  bodyMediumEmphasized(TokenTypescaleEmphasized.bodyMedium),
  bodySmallEmphasized(TokenTypescaleEmphasized.bodySmall);

  const _Typescale(this.struct);

  final TypescaleStruct struct;
}
