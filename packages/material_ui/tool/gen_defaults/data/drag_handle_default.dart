// Copyright 2013 The Flutter Authors.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Version: 38.1.2

import 'shape_struct.dart';

class TokenDragHandleDefault {
  /// md.comp.drag-handle.container.width
  static const double containerWidth = 24.00;

  /// md.comp.drag-handle.elevation
  static const double elevation = 0.00;

  /// md.comp.drag-handle.focus.state-layer.opacity
  static const double focusStateLayerOpacity = 0.10;

  /// md.comp.drag-handle.height
  static const double height = 48.00;

  /// md.comp.drag-handle.hover.state-layer.opacity
  static const double hoverStateLayerOpacity = 0.08;

  /// md.comp.drag-handle.pressed.elevation
  static const double pressedElevation = 0.00;

  /// md.comp.drag-handle.pressed.height
  static const double pressedHeight = 52.00;

  /// md.comp.drag-handle.pressed.shape
  static const ShapeStruct pressedShape = ShapeStruct(
    family: 'SHAPE_FAMILY_ROUNDED_CORNERS',
    topLeft: 12.00,
    topRight: 12.00,
    bottomLeft: 12.00,
    bottomRight: 12.00,
  );

  /// md.comp.drag-handle.pressed.width
  static const double pressedWidth = 12.00;

  /// md.comp.drag-handle.shape
  static const ShapeStruct shape = ShapeStruct(
    family: 'SHAPE_FAMILY_CIRCULAR',
    topLeft: 0.00,
    topRight: 0.00,
    bottomLeft: 0.00,
    bottomRight: 0.00,
  );

  /// md.comp.drag-handle.width
  static const double width = 4.00;
}
