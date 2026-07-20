// Copyright 2013 The Flutter Authors.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Version: 38.0.59

import 'shape_struct.dart';

class TokenNavBar {
  /// md.comp.nav-bar.container.elevation
  static const double containerElevation = 3.00;

  /// md.comp.nav-bar.container.height
  static const double containerHeight = 64.00;

  /// md.comp.nav-bar.container.shape
  static const ShapeStruct containerShape = ShapeStruct(
    family: 'SHAPE_FAMILY_ROUNDED_CORNERS',
    topLeft: 0.00,
    topRight: 0.00,
    bottomLeft: 0.00,
    bottomRight: 0.00,
  );

  /// md.comp.nav-bar.item.active.focused.state-layer.opacity
  static const double itemActiveFocusedStateLayerOpacity = 0.10;

  /// md.comp.nav-bar.item.active.hovered.state-layer.opacity
  static const double itemActiveHoveredStateLayerOpacity = 0.08;

  /// md.comp.nav-bar.item.active-indicator.icon-label-space
  static const double itemActiveIndicatorIconLabelSpace = 4.00;

  /// md.comp.nav-bar.item.active-indicator.shape
  static const ShapeStruct itemActiveIndicatorShape = ShapeStruct(
    family: 'SHAPE_FAMILY_CIRCULAR',
    topLeft: 0.00,
    topRight: 0.00,
    bottomLeft: 0.00,
    bottomRight: 0.00,
  );

  /// md.comp.nav-bar.item.active.pressed.state-layer.opacity
  static const double itemActivePressedStateLayerOpacity = 0.10;

  /// md.comp.nav-bar.item.between-space
  static const double itemBetweenSpace = 0.00;

  /// md.comp.nav-bar.item.icon.size
  static const double itemIconSize = 24.00;
}
