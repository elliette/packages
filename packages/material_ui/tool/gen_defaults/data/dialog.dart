// Copyright 2013 The Flutter Authors.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Version: 38.0.15

import 'shape_struct.dart';
import 'typescale_struct.dart';

class TokenDialog {
  /// md.comp.dialog.action.focus.state-layer.opacity
  static const double actionFocusStateLayerOpacity = 0.10;

  /// md.comp.dialog.action.hover.state-layer.opacity
  static const double actionHoverStateLayerOpacity = 0.08;

  /// md.comp.dialog.action.label-text.type
  static const TypescaleStruct actionLabelTextType = TypescaleStruct(
    fontFamily: 'Roboto',
    fontSize: 14.00,
    fontWeight: 500,
    lineHeight: 20.00,
    letterSpacing: 0.10,
  );

  /// md.comp.dialog.action.pressed.state-layer.opacity
  static const double actionPressedStateLayerOpacity = 0.10;

  /// md.comp.dialog.container.elevation
  static const double containerElevation = 6.00;

  /// md.comp.dialog.container.shape
  static const ShapeStruct containerShape = ShapeStruct(
    family: 'SHAPE_FAMILY_ROUNDED_CORNERS',
    topLeft: 28.00,
    topRight: 28.00,
    bottomLeft: 28.00,
    bottomRight: 28.00,
  );

  /// md.comp.dialog.headline.type
  static const TypescaleStruct headlineType = TypescaleStruct(
    fontFamily: 'Roboto',
    fontSize: 24.00,
    fontWeight: 400,
    lineHeight: 32.00,
    letterSpacing: 0.00,
  );

  /// md.comp.dialog.supporting-text.type
  static const TypescaleStruct supportingTextType = TypescaleStruct(
    fontFamily: 'Roboto',
    fontSize: 14.00,
    fontWeight: 400,
    lineHeight: 20.00,
    letterSpacing: 0.25,
  );

  /// md.comp.dialog.with-icon.icon.size
  static const double withIconIconSize = 24.00;
}
