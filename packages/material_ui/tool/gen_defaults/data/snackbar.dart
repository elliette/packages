// Copyright 2013 The Flutter Authors.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Version: 38.0.15

import 'shape_struct.dart';
import 'typescale_struct.dart';

class TokenSnackbar {
  /// md.comp.snackbar.action.focus.state-layer.opacity
  static const double actionFocusStateLayerOpacity = 0.10;

  /// md.comp.snackbar.action.hover.state-layer.opacity
  static const double actionHoverStateLayerOpacity = 0.08;

  /// md.comp.snackbar.action.label-text.type
  static const TypescaleStruct actionLabelTextType = TypescaleStruct(
    fontFamily: 'Roboto',
    fontSize: 14.00,
    fontWeight: 500,
    lineHeight: 20.00,
    letterSpacing: 0.10,
  );

  /// md.comp.snackbar.action.pressed.state-layer.opacity
  static const double actionPressedStateLayerOpacity = 0.10;

  /// md.comp.snackbar.container.elevation
  static const double containerElevation = 6.00;

  /// md.comp.snackbar.container.shape
  static const ShapeStruct containerShape = ShapeStruct(
    family: 'SHAPE_FAMILY_ROUNDED_CORNERS',
    topLeft: 4.00,
    topRight: 4.00,
    bottomLeft: 4.00,
    bottomRight: 4.00,
  );

  /// md.comp.snackbar.icon.focus.state-layer.opacity
  static const double iconFocusStateLayerOpacity = 0.10;

  /// md.comp.snackbar.icon.hover.state-layer.opacity
  static const double iconHoverStateLayerOpacity = 0.08;

  /// md.comp.snackbar.icon.pressed.state-layer.opacity
  static const double iconPressedStateLayerOpacity = 0.10;

  /// md.comp.snackbar.icon.size
  static const double iconSize = 24.00;

  /// md.comp.snackbar.supporting-text.type
  static const TypescaleStruct supportingTextType = TypescaleStruct(
    fontFamily: 'Roboto',
    fontSize: 14.00,
    fontWeight: 400,
    lineHeight: 20.00,
    letterSpacing: 0.25,
  );

  /// md.comp.snackbar.with-single-line.container.height
  static const double withSingleLineContainerHeight = 48.00;

  /// md.comp.snackbar.with-two-lines.container.height
  static const double withTwoLinesContainerHeight = 68.00;
}
