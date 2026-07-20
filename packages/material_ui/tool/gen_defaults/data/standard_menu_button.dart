// Copyright 2013 The Flutter Authors.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Version: 38.0.59

import 'shape_struct.dart';
import 'typescale_struct.dart';

class TokenStandardMenuButton {
  /// md.comp.standard-menu-button.container.height
  static const double containerHeight = 40.00;

  /// md.comp.standard-menu-button.container.shape
  static const ShapeStruct containerShape = ShapeStruct(
    family: 'SHAPE_FAMILY_CIRCULAR',
    topLeft: 0.00,
    topRight: 0.00,
    bottomLeft: 0.00,
    bottomRight: 0.00,
  );

  /// md.comp.standard-menu-button.disabled.label-text.opacity
  static const double disabledLabelTextOpacity = 0.38;

  /// md.comp.standard-menu-button.disabled.trailing-icon.opacity
  static const double disabledTrailingIconOpacity = 0.38;

  /// md.comp.standard-menu-button.focus.indicator.outline.offset
  static const double focusIndicatorOutlineOffset = 2.00;

  /// md.comp.standard-menu-button.focus.indicator.thickness
  static const double focusIndicatorThickness = 3.00;

  /// md.comp.standard-menu-button.focus.state-layer.opacity
  static const double focusStateLayerOpacity = 0.10;

  /// md.comp.standard-menu-button.hover.state-layer.opacity
  static const double hoverStateLayerOpacity = 0.08;

  /// md.comp.standard-menu-button.label-text.type
  static const TypescaleStruct labelTextType = TypescaleStruct(
    fontFamily: 'Roboto',
    fontSize: 14.00,
    fontWeight: 500,
    lineHeight: 20.00,
    letterSpacing: 0.10,
  );

  /// md.comp.standard-menu-button.pressed.state-layer.opacity
  static const double pressedStateLayerOpacity = 0.10;

  /// md.comp.standard-menu-button.trailing-icon.size
  static const double trailingIconSize = 18.00;

  /// md.comp.standard-menu-button.with-icon.disabled.leading-icon.opacity
  static const double withIconDisabledLeadingIconOpacity = 0.38;

  /// md.comp.standard-menu-button.with-icon.leading-icon.size
  static const double withIconLeadingIconSize = 18.00;
}
