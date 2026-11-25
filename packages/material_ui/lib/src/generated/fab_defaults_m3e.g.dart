// Copyright 2013 The Flutter Authors
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Do not edit by hand. The code is generated from data in the Material
// Design token database by the script:
//   packages/material_ui/tool/gen_defaults/bin/gen_defaults.dart.
part of '../floating_action_button.dart';

class _FABDefaultsM3E extends ButtonStyle {
  _FABDefaultsM3E(this.context, this.type, this._foregroundColor)
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
  static const double extendedIconLabelSpacing = 8.0;

  @override
  WidgetStateProperty<TextStyle?> get textStyle =>
      WidgetStatePropertyAll<TextStyle?>(_textTheme.titleMedium);

  @override
  WidgetStateProperty<Color?>? get backgroundColor =>
      WidgetStatePropertyAll<Color?>(_colors.primaryContainer);

  @override
  WidgetStateProperty<Color?>? get foregroundColor =>
      WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.pressed)) {
          return _colors.onPrimaryContainer;
        }
        if (states.contains(WidgetState.hovered)) {
          return _colors.onPrimaryContainer;
        }
        if (states.contains(WidgetState.focused)) {
          return _colors.onPrimaryContainer;
        }
        return _colors.onPrimaryContainer;
      });

  @override
  WidgetStateProperty<Color?>? get overlayColor =>
      WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.pressed)) {
          return (_foregroundColor ?? _colors.onPrimaryContainer).withValues(alpha: 0.1);
        }
        if (states.contains(WidgetState.hovered)) {
          return (_foregroundColor ?? _colors.onPrimaryContainer).withValues(alpha: 0.08);
        }
        if (states.contains(WidgetState.focused)) {
          return (_foregroundColor ?? _colors.onPrimaryContainer).withValues(alpha: 0.1);
        }
        return null;
      });

  @override
  WidgetStateProperty<Color>? get shadowColor => WidgetStatePropertyAll<Color>(_colors.shadow);

  @override
  WidgetStateProperty<Color>? get surfaceTintColor =>
      const WidgetStatePropertyAll<Color>(Colors.transparent);

  @override
  WidgetStateProperty<double>? get elevation =>
      WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        // There is no disabled elevation token, so a disabled floating action
        // button keeps its resting elevation.
        if (states.contains(WidgetState.disabled)) {
          return 6.0;
        }
        if (states.contains(WidgetState.pressed)) {
          return 6.0;
        }
        if (states.contains(WidgetState.hovered)) {
          return 8.0;
        }
        if (states.contains(WidgetState.focused)) {
          return 6.0;
        }
        return 6.0;
      });

  @override
  WidgetStateProperty<EdgeInsetsGeometry>? get padding =>
      WidgetStatePropertyAll<EdgeInsetsGeometry>(
        _isExtended ? const EdgeInsetsDirectional.only(start: 16.0, end: 16.0) : EdgeInsets.zero,
      );

  @override
  WidgetStateProperty<Size>? get minimumSize => WidgetStatePropertyAll<Size>(switch (type) {
    _FloatingActionButtonType.regular => const Size(56.0, 56.0),
    _FloatingActionButtonType.small => const Size(40.0, 40.0),
    _FloatingActionButtonType.medium => const Size(80.0, 80.0),
    _FloatingActionButtonType.large => const Size(96.0, 96.0),
    _FloatingActionButtonType.extended => const Size(0.0, 56.0),
  });

  @override
  WidgetStateProperty<Size>? get maximumSize => WidgetStatePropertyAll<Size>(switch (type) {
    _FloatingActionButtonType.regular => const Size(56.0, 56.0),
    _FloatingActionButtonType.small => const Size(40.0, 40.0),
    _FloatingActionButtonType.medium => const Size(80.0, 80.0),
    _FloatingActionButtonType.large => const Size(96.0, 96.0),
    _FloatingActionButtonType.extended => const Size.fromHeight(56.0),
  });

  @override
  WidgetStateProperty<double>? get iconSize => WidgetStatePropertyAll<double>(switch (type) {
    _FloatingActionButtonType.regular => 24.0,
    _FloatingActionButtonType.small => 24.0,
    _FloatingActionButtonType.medium => 28.0,
    _FloatingActionButtonType.large => 36.0,
    _FloatingActionButtonType.extended => 24.0,
  });

  @override
  WidgetStateProperty<OutlinedBorder>? get shape =>
      WidgetStatePropertyAll<OutlinedBorder>(switch (type) {
        _FloatingActionButtonType.regular => const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        _FloatingActionButtonType.small => const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        _FloatingActionButtonType.medium => const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        _FloatingActionButtonType.large => const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(28.0)),
        ),
        _FloatingActionButtonType.extended => const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
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
