// Copyright 2013 The Flutter Authors.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Version: 38.1.0

import 'shape_struct.dart';
import 'typescale_struct.dart';

class TokenExtendedFabSurface {
  /// md.comp.extended-fab.surface.container.elevation
  static const double containerElevation = 6.00;

  /// md.comp.extended-fab.surface.container.height
  static const double containerHeight = 56.00;

  /// md.comp.extended-fab.surface.container.shape
  static const ShapeStruct containerShape = ShapeStruct(
    family: 'SHAPE_FAMILY_ROUNDED_CORNERS',
    topLeft: 16.00,
    topRight: 16.00,
    bottomLeft: 16.00,
    bottomRight: 16.00,
  );

  /// md.comp.extended-fab.surface.focus.container.elevation
  static const double focusContainerElevation = 6.00;

  /// md.comp.extended-fab.surface.focus.indicator.outline.offset
  static const double focusIndicatorOutlineOffset = 2.00;

  /// md.comp.extended-fab.surface.focus.indicator.thickness
  static const double focusIndicatorThickness = 3.00;

  /// md.comp.extended-fab.surface.focus.state-layer.opacity
  static const double focusStateLayerOpacity = 0.10;

  /// md.comp.extended-fab.surface.hover.container.elevation
  static const double hoverContainerElevation = 8.00;

  /// md.comp.extended-fab.surface.hover.state-layer.opacity
  static const double hoverStateLayerOpacity = 0.08;

  /// md.comp.extended-fab.surface.icon.size
  static const double iconSize = 24.00;

  /// md.comp.extended-fab.surface.label-text.type
  static const TypescaleStruct labelTextType = TypescaleStruct(
    fontFamily: 'Roboto',
    fontSize: 14.00,
    fontWeight: 500,
    lineHeight: 20.00,
    letterSpacing: 0.10,
  );

  /// md.comp.extended-fab.surface.lowered.container.elevation
  static const double loweredContainerElevation = 1.00;

  /// md.comp.extended-fab.surface.lowered.focus.container.elevation
  static const double loweredFocusContainerElevation = 1.00;

  /// md.comp.extended-fab.surface.lowered.hover.container.elevation
  static const double loweredHoverContainerElevation = 3.00;

  /// md.comp.extended-fab.surface.lowered.pressed.container.elevation
  static const double loweredPressedContainerElevation = 1.00;

  /// md.comp.extended-fab.surface.pressed.container.elevation
  static const double pressedContainerElevation = 6.00;

  /// md.comp.extended-fab.surface.pressed.state-layer.opacity
  static const double pressedStateLayerOpacity = 0.10;
}
