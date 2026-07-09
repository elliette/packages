// Copyright 2013 The Flutter Authors.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Version: 38.0.15

import 'shape_struct.dart';
import 'typescale_struct.dart';

class TokenNavigationBar {
  /// md.comp.navigation-bar.active-indicator.height
  static const double activeIndicatorHeight = 32.00;

  /// md.comp.navigation-bar.active-indicator.shape
  static const ShapeStruct activeIndicatorShape = ShapeStruct(
    family: 'SHAPE_FAMILY_CIRCULAR',
    topLeft: 0.00,
    topRight: 0.00,
    bottomLeft: 0.00,
    bottomRight: 0.00,
  );

  /// md.comp.navigation-bar.active-indicator.width
  static const double activeIndicatorWidth = 64.00;

  /// md.comp.navigation-bar.container.elevation
  static const double containerElevation = 3.00;

  /// md.comp.navigation-bar.container.height
  static const double containerHeight = 80.00;

  /// md.comp.navigation-bar.container.shape
  static const ShapeStruct containerShape = ShapeStruct(
    family: 'SHAPE_FAMILY_ROUNDED_CORNERS',
    topLeft: 0.00,
    topRight: 0.00,
    bottomLeft: 0.00,
    bottomRight: 0.00,
  );

  /// md.comp.navigation-bar.focus.indicator.outline.offset
  static const double focusIndicatorOutlineOffset = -3.00;

  /// md.comp.navigation-bar.focus.indicator.thickness
  static const double focusIndicatorThickness = 3.00;

  /// md.comp.navigation-bar.focus.state-layer.opacity
  static const double focusStateLayerOpacity = 0.10;

  /// md.comp.navigation-bar.hover.state-layer.opacity
  static const double hoverStateLayerOpacity = 0.08;

  /// md.comp.navigation-bar.icon.size
  static const double iconSize = 24.00;

  /// md.comp.navigation-bar.label-text.type
  static const TypescaleStruct labelTextType = TypescaleStruct(
    fontFamily: 'Roboto',
    fontSize: 12.00,
    fontWeight: 500,
    lineHeight: 16.00,
    letterSpacing: 0.50,
  );

  /// md.comp.navigation-bar.pressed.state-layer.opacity
  static const double pressedStateLayerOpacity = 0.10;
}
