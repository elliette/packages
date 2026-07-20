// Copyright 2013 The Flutter Authors.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Version: 38.0.59

import 'shape_struct.dart';

class TokenToolbarStandard {
  /// md.comp.toolbar.standard.container.shape
  static const ShapeStruct containerShape = ShapeStruct(
    family: 'SHAPE_FAMILY_CIRCULAR',
    topLeft: 0.00,
    topRight: 0.00,
    bottomLeft: 0.00,
    bottomRight: 0.00,
  );

  /// md.comp.toolbar.standard.disabled.icon.opacity
  static const double disabledIconOpacity = 0.38;

  /// md.comp.toolbar.standard.disabled.label-text.opacity
  static const double disabledLabelTextOpacity = 0.38;

  /// md.comp.toolbar.standard.focused.state-layer.opacity
  static const double focusedStateLayerOpacity = 0.10;

  /// md.comp.toolbar.standard.hovered.state-layer.opacity
  static const double hoveredStateLayerOpacity = 0.08;

  /// md.comp.toolbar.standard.pressed.state-layer.opacity
  static const double pressedStateLayerOpacity = 0.10;
}
