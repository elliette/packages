// Copyright 2013 The Flutter Authors.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Version: 38.1.2

import 'shape_struct.dart';
import 'typescale_struct.dart';

class TokenRichTooltipDefault {
  /// md.comp.rich-tooltip.action.focus.state-layer.opacity
  static const double actionFocusStateLayerOpacity = 0.10;

  /// md.comp.rich-tooltip.action.hover.state-layer.opacity
  static const double actionHoverStateLayerOpacity = 0.08;

  /// md.comp.rich-tooltip.action.label-text.type
  static const TypescaleStruct actionLabelTextType = TypescaleStruct(
    fontFamily: 'Roboto',
    fontSize: 14.00,
    fontWeight: 500,
    lineHeight: 20.00,
    letterSpacing: 0.10,
  );

  /// md.comp.rich-tooltip.action.pressed.state-layer.opacity
  static const double actionPressedStateLayerOpacity = 0.10;

  /// md.comp.rich-tooltip.container.elevation
  static const double containerElevation = 3.00;

  /// md.comp.rich-tooltip.container.shape
  static const ShapeStruct containerShape = ShapeStruct(
    family: 'SHAPE_FAMILY_ROUNDED_CORNERS',
    topLeft: 12.00,
    topRight: 12.00,
    bottomLeft: 12.00,
    bottomRight: 12.00,
  );

  /// md.comp.rich-tooltip.subhead.type
  static const TypescaleStruct subheadType = TypescaleStruct(
    fontFamily: 'Roboto',
    fontSize: 14.00,
    fontWeight: 500,
    lineHeight: 20.00,
    letterSpacing: 0.10,
  );

  /// md.comp.rich-tooltip.supporting-text.type
  static const TypescaleStruct supportingTextType = TypescaleStruct(
    fontFamily: 'Roboto',
    fontSize: 14.00,
    fontWeight: 400,
    lineHeight: 20.00,
    letterSpacing: 0.25,
  );
}
