// Copyright 2013 The Flutter Authors.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Version: 38.1.0

import 'shape_struct.dart';
import 'typescale_struct.dart';

class TokenSheetSide {
  /// md.comp.sheet.side.detached.container.shape
  static const ShapeStruct detachedContainerShape = ShapeStruct(
    family: 'SHAPE_FAMILY_ROUNDED_CORNERS',
    topLeft: 16.00,
    topRight: 16.00,
    bottomLeft: 16.00,
    bottomRight: 16.00,
  );

  /// md.comp.sheet.side.docked.action.focus.state-layer.opacity
  static const double dockedActionFocusStateLayerOpacity = 0.10;

  /// md.comp.sheet.side.docked.action.hover.state-layer.opacity
  static const double dockedActionHoverStateLayerOpacity = 0.08;

  /// md.comp.sheet.side.docked.action.pressed.state-layer.opacity
  static const double dockedActionPressedStateLayerOpacity = 0.10;

  /// md.comp.sheet.side.docked.container.height
  static const double dockedContainerHeight = 100.00;

  /// md.comp.sheet.side.docked.container.shape
  static const ShapeStruct dockedContainerShape = ShapeStruct(
    family: 'SHAPE_FAMILY_ROUNDED_CORNERS',
    topLeft: 0.00,
    topRight: 0.00,
    bottomLeft: 0.00,
    bottomRight: 0.00,
  );

  /// md.comp.sheet.side.docked.container.width
  static const double dockedContainerWidth = 256.00;

  /// md.comp.sheet.side.docked.focus.indicator.outline.offset
  static const double dockedFocusIndicatorOutlineOffset = 2.00;

  /// md.comp.sheet.side.docked.focus.indicator.thickness
  static const double dockedFocusIndicatorThickness = 3.00;

  /// md.comp.sheet.side.docked.headline.type
  static const TypescaleStruct dockedHeadlineType = TypescaleStruct(
    fontFamily: 'Roboto',
    fontSize: 22.00,
    fontWeight: 400,
    lineHeight: 28.00,
    letterSpacing: 0.00,
  );

  /// md.comp.sheet.side.docked.modal.container.elevation
  static const double dockedModalContainerElevation = 1.00;

  /// md.comp.sheet.side.docked.modal.container.shape
  static const ShapeStruct dockedModalContainerShape = ShapeStruct(
    family: 'SHAPE_FAMILY_ROUNDED_CORNERS',
    topLeft: 16.00,
    topRight: 0.00,
    bottomLeft: 16.00,
    bottomRight: 0.00,
  );

  /// md.comp.sheet.side.docked.standard.container.elevation
  static const double dockedStandardContainerElevation = 0.00;
}
