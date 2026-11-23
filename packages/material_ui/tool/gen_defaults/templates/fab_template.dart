// Copyright 2013 The Flutter Authors
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '../data/color_role.dart';
import '../data/extended_fab.dart';
import '../data/extended_fab_small.dart';
import '../data/fab.dart';
import '../data/fab_large.dart';
import '../data/fab_primary_container.dart';
import '../data/fab_small.dart';
import 'template.dart';

class FabTemplateM3 extends TokenTemplateM3 {
  const FabTemplateM3();

  @override
  String get name => 'FAB';

  @override
  String get parentFilePath => 'floating_action_button.dart';

  @override
  String get className => '_FABDefaultsM3';

  @override
  String generateContents(String className) =>
      '''
class $className extends FloatingActionButtonThemeData {
  $className(this.context, this.type, this.hasChild)
    : super(
        elevation: ${number(TokenFabPrimaryContainer.containerElevation)},
        focusElevation: ${number(TokenFabPrimaryContainer.focusedContainerElevation)},
        hoverElevation: ${number(TokenFabPrimaryContainer.hoveredContainerElevation)},
        highlightElevation: ${number(TokenFabPrimaryContainer.pressedContainerElevation)},
        enableFeedback: true,
        sizeConstraints: const BoxConstraints.tightFor(
          width: ${number(TokenFab.containerWidth)},
          height: ${number(TokenFab.containerHeight)},
        ),
        smallSizeConstraints: const BoxConstraints.tightFor(
          width: ${number(TokenFabSmall.containerWidth)},
          height: ${number(TokenFabSmall.containerHeight)},
        ),
        largeSizeConstraints: const BoxConstraints.tightFor(
          width: ${number(TokenFabLarge.containerWidth)},
          height: ${number(TokenFabLarge.containerHeight)},
        ),
        extendedSizeConstraints: const BoxConstraints.tightFor(
          height: ${number(TokenExtendedFab.containerHeight)},
        ),
        extendedIconLabelSpacing: 8.0,
      );

  final BuildContext context;
  final _FloatingActionButtonType type;
  final bool hasChild;
  late final ColorScheme _colors = Theme.of(context).colorScheme;
  late final TextTheme _textTheme = Theme.of(context).textTheme;

  bool get _isExtended => type == _FloatingActionButtonType.extended;

  @override Color? get foregroundColor => ${color(TokenFabPrimaryContainer.iconColor)};
  @override Color? get backgroundColor => ${color(TokenFabPrimaryContainer.containerColor)};
  @override Color? get splashColor => ${colorWithOpacity(TokenFabPrimaryContainer.pressedStateLayerColor, TokenFabPrimaryContainer.pressedStateLayerOpacity)};
  @override Color? get focusColor => ${colorWithOpacity(TokenFabPrimaryContainer.focusedStateLayerColor, TokenFabPrimaryContainer.focusedStateLayerOpacity)};
  @override Color? get hoverColor => ${colorWithOpacity(TokenFabPrimaryContainer.hoveredStateLayerColor, TokenFabPrimaryContainer.hoveredStateLayerOpacity)};

  @override
  ShapeBorder? get shape => switch (type) {
    _FloatingActionButtonType.regular  => ${shape(TokenFab.containerShape)},
    _FloatingActionButtonType.small    => ${shape(TokenFabSmall.containerShape)},
    _FloatingActionButtonType.large    => ${shape(TokenFabLarge.containerShape)},
    _FloatingActionButtonType.extended => ${shape(TokenExtendedFab.containerShape)},
  };

  @override
  double? get iconSize => switch (type) {
    _FloatingActionButtonType.regular  => ${number(TokenFab.iconSize)},
    _FloatingActionButtonType.small    => ${number(TokenFabSmall.iconSize)},
    _FloatingActionButtonType.large    => ${number(TokenFabLarge.iconSize)},
    _FloatingActionButtonType.extended => ${number(TokenExtendedFab.iconSize)},
  };

  @override EdgeInsetsGeometry? get extendedPadding => EdgeInsetsDirectional.only(start: hasChild && _isExtended ? ${number(TokenExtendedFab.leadingSpace)} : ${number(TokenExtendedFab.trailingSpace)}, end: ${number(TokenExtendedFab.trailingSpace)});
  @override TextStyle? get extendedTextStyle => ${textStyle(TokenExtendedFab.labelText, '_textTheme')};
}
''';
}

class FabTemplateM3E extends TokenTemplateM3E {
  const FabTemplateM3E();

  @override
  String get name => 'FAB';

  @override
  String get parentFilePath => 'floating_action_button.dart';

  @override
  String get className => '_FABDefaultsM3E';

  String _size(double width, double height) => 'const Size(${number(width)}, ${number(height)})';

  // The state layer follows the effective foreground color, if one was
  // specified on the widget or in the theme.
  String _stateLayer(TokenColorRole role, double opacity) =>
      '(_foregroundColor ?? ${color(role)}).withValues(alpha: ${number(opacity)})';

  @override
  String generateContents(String className) =>
      '''
class $className extends ButtonStyle {
  $className(this.context, this.type, this._foregroundColor)
    : super(
        animationDuration: kThemeChangeDuration,
        enableFeedback: true,
        alignment: Alignment.center,
      );

  final BuildContext context;
  final _FloatingActionButtonType type;
  final Color? _foregroundColor;
  late final ColorScheme _colors = Theme.of(context).colorScheme;
  late final TextTheme _textTheme = Theme.of(context).textTheme;

  bool get _isExtended => type == _FloatingActionButtonType.extended;

  /// The space between the icon and the label of an extended floating action
  /// button.
  static const double extendedIconLabelSpacing = ${number(TokenExtendedFabSmall.iconLabelSpace)};

  @override
  WidgetStateProperty<TextStyle?> get textStyle =>
      WidgetStatePropertyAll<TextStyle?>(${textStyle(TokenExtendedFabSmall.labelText, '_textTheme')});

  @override
  WidgetStateProperty<Color?>? get backgroundColor =>
      WidgetStatePropertyAll<Color?>(${color(TokenFabPrimaryContainer.containerColor)});

  @override
  WidgetStateProperty<Color?>? get foregroundColor =>
      WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.pressed)) {
          return ${color(TokenFabPrimaryContainer.pressedIconColor)};
        }
        if (states.contains(WidgetState.hovered)) {
          return ${color(TokenFabPrimaryContainer.hoveredIconColor)};
        }
        if (states.contains(WidgetState.focused)) {
          return ${color(TokenFabPrimaryContainer.focusedIconColor)};
        }
        return ${color(TokenFabPrimaryContainer.iconColor)};
      });

  @override
  WidgetStateProperty<Color?>? get overlayColor =>
      WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.pressed)) {
          return ${_stateLayer(TokenFabPrimaryContainer.pressedStateLayerColor, TokenFabPrimaryContainer.pressedStateLayerOpacity)};
        }
        if (states.contains(WidgetState.hovered)) {
          return ${_stateLayer(TokenFabPrimaryContainer.hoveredStateLayerColor, TokenFabPrimaryContainer.hoveredStateLayerOpacity)};
        }
        if (states.contains(WidgetState.focused)) {
          return ${_stateLayer(TokenFabPrimaryContainer.focusedStateLayerColor, TokenFabPrimaryContainer.focusedStateLayerOpacity)};
        }
        return null;
      });

  @override
  WidgetStateProperty<Color>? get shadowColor =>
      WidgetStatePropertyAll<Color>(${color(TokenFabPrimaryContainer.containerShadowColor)});

  @override
  WidgetStateProperty<Color>? get surfaceTintColor =>
      const WidgetStatePropertyAll<Color>(Colors.transparent);

  @override
  WidgetStateProperty<double>? get elevation =>
      WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        // There is no disabled elevation token, so a disabled floating action
        // button keeps its resting elevation.
        if (states.contains(WidgetState.disabled)) {
          return ${number(TokenFabPrimaryContainer.containerElevation)};
        }
        if (states.contains(WidgetState.pressed)) {
          return ${number(TokenFabPrimaryContainer.pressedContainerElevation)};
        }
        if (states.contains(WidgetState.hovered)) {
          return ${number(TokenFabPrimaryContainer.hoveredContainerElevation)};
        }
        if (states.contains(WidgetState.focused)) {
          return ${number(TokenFabPrimaryContainer.focusedContainerElevation)};
        }
        return ${number(TokenFabPrimaryContainer.containerElevation)};
      });

  @override
  WidgetStateProperty<EdgeInsetsGeometry>? get padding =>
      WidgetStatePropertyAll<EdgeInsetsGeometry>(
        _isExtended
            ? const EdgeInsetsDirectional.only(
                start: ${number(TokenExtendedFabSmall.leadingSpace)},
                end: ${number(TokenExtendedFabSmall.trailingSpace)},
              )
            : EdgeInsets.zero,
      );

  @override
  WidgetStateProperty<Size>? get minimumSize => WidgetStatePropertyAll<Size>(switch (type) {
    _FloatingActionButtonType.regular  => ${_size(TokenFab.containerWidth, TokenFab.containerHeight)},
    _FloatingActionButtonType.small    => ${_size(TokenFabSmall.containerWidth, TokenFabSmall.containerHeight)},
    _FloatingActionButtonType.large    => ${_size(TokenFabLarge.containerWidth, TokenFabLarge.containerHeight)},
    _FloatingActionButtonType.extended => ${_size(0, TokenExtendedFabSmall.containerHeight)},
  });

  @override
  WidgetStateProperty<Size>? get maximumSize => WidgetStatePropertyAll<Size>(switch (type) {
    _FloatingActionButtonType.regular  => ${_size(TokenFab.containerWidth, TokenFab.containerHeight)},
    _FloatingActionButtonType.small    => ${_size(TokenFabSmall.containerWidth, TokenFabSmall.containerHeight)},
    _FloatingActionButtonType.large    => ${_size(TokenFabLarge.containerWidth, TokenFabLarge.containerHeight)},
    _FloatingActionButtonType.extended => const Size.fromHeight(${number(TokenExtendedFabSmall.containerHeight)}),
  });

  @override
  WidgetStateProperty<double>? get iconSize => WidgetStatePropertyAll<double>(switch (type) {
    _FloatingActionButtonType.regular  => ${number(TokenFab.iconSize)},
    _FloatingActionButtonType.small    => ${number(TokenFabSmall.iconSize)},
    _FloatingActionButtonType.large    => ${number(TokenFabLarge.iconSize)},
    _FloatingActionButtonType.extended => ${number(TokenExtendedFabSmall.iconSize)},
  });

  @override
  WidgetStateProperty<OutlinedBorder>? get shape => WidgetStatePropertyAll<OutlinedBorder>(switch (type) {
    _FloatingActionButtonType.regular  => ${shape(TokenFab.containerShape)},
    _FloatingActionButtonType.small    => ${shape(TokenFabSmall.containerShape)},
    _FloatingActionButtonType.large    => ${shape(TokenFabLarge.containerShape)},
    _FloatingActionButtonType.extended => ${shape(TokenExtendedFabSmall.containerShape)},
  });

  @override
  WidgetStateProperty<MouseCursor?>? get mouseCursor => WidgetStateMouseCursor.adaptiveClickable;

  @override
  VisualDensity? get visualDensity => VisualDensity.standard;

  @override
  MaterialTapTargetSize? get tapTargetSize => Theme.of(context).materialTapTargetSize;

  @override
  InteractiveInkFeatureFactory? get splashFactory => Theme.of(context).splashFactory;
}
''';
}
