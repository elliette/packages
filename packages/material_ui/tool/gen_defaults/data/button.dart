// Copyright 2013 The Flutter Authors.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Version: 38.0.15

import 'shape_struct.dart';
import 'typescale_struct.dart';

class TokenButton {
  /// md.comp.button.container.elevation
  static const double containerElevation = 0.00;

  /// md.comp.button.container.height
  static const double containerHeight = 40.00;

  /// md.comp.button.container.shape.round
  static const ShapeStruct containerShapeRound = ShapeStruct(
    family: 'SHAPE_FAMILY_CIRCULAR',
    topLeft: 0.00,
    topRight: 0.00,
    bottomLeft: 0.00,
    bottomRight: 0.00,
  );

  /// md.comp.button.container.shape.square
  static const ShapeStruct containerShapeSquare = ShapeStruct(
    family: 'SHAPE_FAMILY_ROUNDED_CORNERS',
    topLeft: 12.00,
    topRight: 12.00,
    bottomLeft: 12.00,
    bottomRight: 12.00,
  );

  /// md.comp.button.disabled.container.elevation
  static const double disabledContainerElevation = 0.00;

  /// md.comp.button.disabled.container.opacity
  static const double disabledContainerOpacity = 0.10;

  /// md.comp.button.disabled.icon.opacity
  static const double disabledIconOpacity = 0.38;

  /// md.comp.button.disabled.label-text.opacity
  static const double disabledLabelTextOpacity = 0.38;

  /// md.comp.button.focus.indicator.outline.offset
  static const double focusIndicatorOutlineOffset = 2.00;

  /// md.comp.button.focus.indicator.thickness
  static const double focusIndicatorThickness = 3.00;

  /// md.comp.button.focused.container.elevation
  static const double focusedContainerElevation = 0.00;

  /// md.comp.button.focused.state-layer.opacity
  static const double focusedStateLayerOpacity = 0.10;

  /// md.comp.button.hovered.state-layer.opacity
  static const double hoveredStateLayerOpacity = 0.08;

  /// md.comp.button.icon-label-space
  static const double iconLabelSpace = 8.00;

  /// md.comp.button.icon.size
  static const double iconSize = 20.00;

  /// md.comp.button.label-text
  static const TypescaleStruct labelText = TypescaleStruct(
    fontFamily: 'Roboto',
    fontSize: 14.00,
    fontWeight: 500,
    lineHeight: 20.00,
    letterSpacing: 0.10,
  );

  /// md.comp.button.leading-space
  static const double leadingSpace = 24.00;

  /// md.comp.button.pressed.container.corner-size.motion.spring.damping
  static const double pressedContainerCornerSizeMotionSpringDamping = 0.60;

  /// md.comp.button.pressed.container.corner-size.motion.spring.stiffness
  static const double pressedContainerCornerSizeMotionSpringStiffness = 800.00;

  /// md.comp.button.pressed.container.elevation
  static const double pressedContainerElevation = 0.00;

  /// md.comp.button.pressed.container.shape
  static const ShapeStruct pressedContainerShape = ShapeStruct(
    family: 'SHAPE_FAMILY_ROUNDED_CORNERS',
    topLeft: 8.00,
    topRight: 8.00,
    bottomLeft: 8.00,
    bottomRight: 8.00,
  );

  /// md.comp.button.pressed.state-layer.opacity
  static const double pressedStateLayerOpacity = 0.10;

  /// md.comp.button.selected.container.shape.round
  static const ShapeStruct selectedContainerShapeRound = ShapeStruct(
    family: 'SHAPE_FAMILY_ROUNDED_CORNERS',
    topLeft: 12.00,
    topRight: 12.00,
    bottomLeft: 12.00,
    bottomRight: 12.00,
  );

  /// md.comp.button.selected.container.shape.square
  static const ShapeStruct selectedContainerShapeSquare = ShapeStruct(
    family: 'SHAPE_FAMILY_CIRCULAR',
    topLeft: 0.00,
    topRight: 0.00,
    bottomLeft: 0.00,
    bottomRight: 0.00,
  );

  /// md.comp.button.trailing-space
  static const double trailingSpace = 24.00;
}
