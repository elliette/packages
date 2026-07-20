// Copyright 2013 The Flutter Authors.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Version: 38.0.59

import 'shape_struct.dart';

class TokenElevatedCard {
  /// md.comp.elevated-card.container.elevation
  static const double containerElevation = 1.00;

  /// md.comp.elevated-card.container.shape
  static const ShapeStruct containerShape = ShapeStruct(
    family: 'SHAPE_FAMILY_ROUNDED_CORNERS',
    topLeft: 12.00,
    topRight: 12.00,
    bottomLeft: 12.00,
    bottomRight: 12.00,
  );

  /// md.comp.elevated-card.disabled.container.elevation
  static const double disabledContainerElevation = 1.00;

  /// md.comp.elevated-card.disabled.container.opacity
  static const double disabledContainerOpacity = 0.38;

  /// md.comp.elevated-card.dragged.container.elevation
  static const double draggedContainerElevation = 8.00;

  /// md.comp.elevated-card.dragged.state-layer.opacity
  static const double draggedStateLayerOpacity = 0.16;

  /// md.comp.elevated-card.focus.container.elevation
  static const double focusContainerElevation = 1.00;

  /// md.comp.elevated-card.focus.indicator.outline.offset
  static const double focusIndicatorOutlineOffset = 2.00;

  /// md.comp.elevated-card.focus.indicator.thickness
  static const double focusIndicatorThickness = 3.00;

  /// md.comp.elevated-card.focus.state-layer.opacity
  static const double focusStateLayerOpacity = 0.10;

  /// md.comp.elevated-card.hover.container.elevation
  static const double hoverContainerElevation = 3.00;

  /// md.comp.elevated-card.hover.state-layer.opacity
  static const double hoverStateLayerOpacity = 0.08;

  /// md.comp.elevated-card.icon.size
  static const double iconSize = 24.00;

  /// md.comp.elevated-card.pressed.container.elevation
  static const double pressedContainerElevation = 1.00;

  /// md.comp.elevated-card.pressed.state-layer.opacity
  static const double pressedStateLayerOpacity = 0.10;
}
