// Copyright 2013 The Flutter Authors.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Version: 38.0.14

import 'shape_struct.dart';
import 'typescale_struct.dart';

class TokenNavigationDrawer {
  /// md.comp.navigation-drawer.active-indicator.height
  static const double activeIndicatorHeight = 56.00;

  /// md.comp.navigation-drawer.active-indicator.shape
  static const ShapeStruct activeIndicatorShape = ShapeStruct(
    family: 'SHAPE_FAMILY_CIRCULAR',
    topLeft: 0.00,
    topRight: 0.00,
    bottomLeft: 0.00,
    bottomRight: 0.00,
  );

  /// md.comp.navigation-drawer.active-indicator.width
  static const double activeIndicatorWidth = 336.00;

  /// md.comp.navigation-drawer.bottom.container.shape
  static const ShapeStruct bottomContainerShape = ShapeStruct(
    family: 'SHAPE_FAMILY_ROUNDED_CORNERS',
    topLeft: 16.00,
    topRight: 16.00,
    bottomLeft: 0.00,
    bottomRight: 0.00,
  );

  /// md.comp.navigation-drawer.container.height
  static const double containerHeight = 100.00;

  /// md.comp.navigation-drawer.container.shape
  static const ShapeStruct containerShape = ShapeStruct(
    family: 'SHAPE_FAMILY_ROUNDED_CORNERS',
    topLeft: 0.00,
    topRight: 16.00,
    bottomLeft: 0.00,
    bottomRight: 16.00,
  );

  /// md.comp.navigation-drawer.container.width
  static const double containerWidth = 360.00;

  /// md.comp.navigation-drawer.focus.indicator.outline.offset
  static const double focusIndicatorOutlineOffset = -3.00;

  /// md.comp.navigation-drawer.focus.indicator.thickness
  static const double focusIndicatorThickness = 3.00;

  /// md.comp.navigation-drawer.focus.state-layer.opacity
  static const double focusStateLayerOpacity = 0.10;

  /// md.comp.navigation-drawer.headline.type
  static const TypescaleStruct headlineType = TypescaleStruct(
    fontFamily: 'Roboto',
    fontSize: 14.00,
    fontWeight: 500,
    lineHeight: 20.00,
    letterSpacing: 0.10,
  );

  /// md.comp.navigation-drawer.hover.state-layer.opacity
  static const double hoverStateLayerOpacity = 0.08;

  /// md.comp.navigation-drawer.icon.size
  static const double iconSize = 24.00;

  /// md.comp.navigation-drawer.label-text.type
  static const TypescaleStruct labelTextType = TypescaleStruct(
    fontFamily: 'Roboto',
    fontSize: 14.00,
    fontWeight: 500,
    lineHeight: 20.00,
    letterSpacing: 0.10,
  );

  /// md.comp.navigation-drawer.large-badge-label.type
  static const TypescaleStruct largeBadgeLabelType = TypescaleStruct(
    fontFamily: 'Roboto',
    fontSize: 14.00,
    fontWeight: 500,
    lineHeight: 20.00,
    letterSpacing: 0.10,
  );

  /// md.comp.navigation-drawer.modal.container.elevation
  static const double modalContainerElevation = 1.00;

  /// md.comp.navigation-drawer.pressed.state-layer.opacity
  static const double pressedStateLayerOpacity = 0.10;

  /// md.comp.navigation-drawer.standard.container.elevation
  static const double standardContainerElevation = 0.00;
}
