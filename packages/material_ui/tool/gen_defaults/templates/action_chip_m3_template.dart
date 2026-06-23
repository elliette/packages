// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '../data/assist_chip.dart';
import 'template.dart';

class M3ActionChipTemplate extends M3TokenTemplate {
  const M3ActionChipTemplate();

  @override
  String get name => 'Action Chip';

  @override
  String get parentFilePath => 'action_chip.dart';

  @override
  String generateContents(String className) =>
      '''
class $className extends ChipThemeData {
  $className(this.context, this.isEnabled, this._chipVariant)
    : super(
        shape: ${shape(TokenAssistChip.containerShape)},
        showCheckmark: true,
      );

  final BuildContext context;
  final bool isEnabled;
  final _ChipVariant _chipVariant;
  late final ColorScheme _colors = Theme.of(context).colorScheme;
  late final TextTheme _textTheme = Theme.of(context).textTheme;

  @override
  double? get elevation => _chipVariant == _ChipVariant.flat
    ? ${TokenAssistChip.flatContainerElevation}
    : isEnabled ? ${TokenAssistChip.elevatedContainerElevation} : ${TokenAssistChip.elevatedDisabledContainerElevation};

  @override
  double? get pressElevation => ${TokenAssistChip.elevatedPressedContainerElevation};

  @override
  TextStyle? get labelStyle => _textTheme.labelLarge?.copyWith(
    color: isEnabled
      ? ${color(TokenAssistChip.labelTextColor)}
      : ${color(TokenAssistChip.disabledLabelTextColor)},
  );

  @override
  WidgetStateProperty<Color?>? get color =>
    WidgetStateProperty.resolveWith((Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) {
        return _chipVariant == _ChipVariant.flat
          ? null
          : ${componentColor(TokenAssistChip.elevatedDisabledContainerColor, TokenAssistChip.elevatedDisabledContainerOpacity)};
      }
      return _chipVariant == _ChipVariant.flat
        ? null
        : ${componentColor(TokenAssistChip.elevatedContainerColor)};
    });

  @override
  Color? get shadowColor => _chipVariant == _ChipVariant.flat
    ? Colors.transparent
    : ${colorOrTransparent(TokenAssistChip.elevatedContainerShadowColor)};

  @override
  Color? get surfaceTintColor => Colors.transparent;

  @override
  Color? get checkmarkColor => null;

  @override
  Color? get deleteIconColor => null;

  @override
  BorderSide? get side => _chipVariant == _ChipVariant.flat
    ? isEnabled
        ? ${border(TokenAssistChip.flatOutlineColor, width: TokenAssistChip.flatOutlineWidth)}
        : ${border(TokenAssistChip.flatDisabledOutlineColor, opacity: TokenAssistChip.flatDisabledOutlineOpacity)}
    : const BorderSide(color: Colors.transparent);

  @override
  IconThemeData? get iconTheme => IconThemeData(
    color: isEnabled
      ? ${color(TokenAssistChip.withIconIconColor)}
      : ${color(TokenAssistChip.withIconDisabledIconColor)},
    size: ${TokenAssistChip.withIconIconSize},
  );

  @override
  EdgeInsetsGeometry? get padding => const EdgeInsets.all(8.0);

  /// The label padding of the chip scales with the font size specified in the
  /// [labelStyle], and the system font size settings that scale font sizes
  /// globally.
  ///
  /// The chip at effective font size 14.0 starts with 8px on each side and as
  /// the font size scales up to closer to 28.0, the label padding is linearly
  /// interpolated from 8px to 4px. Once the label has a font size of 2 or
  /// higher, label padding remains 4px.
  @override
  EdgeInsetsGeometry? get labelPadding {
    final double fontSize = labelStyle?.fontSize ?? 14.0;
    final double fontSizeRatio = MediaQuery.textScalerOf(context).scale(fontSize) / 14.0;
    return EdgeInsets.lerp(
      const EdgeInsets.symmetric(horizontal: 8.0),
      const EdgeInsets.symmetric(horizontal: 4.0),
      clampDouble(fontSizeRatio - 1.0, 0.0, 1.0),
    )!;
  }
}
''';
}
