// Copyright 2013 The Flutter Authors.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Version: 38.0.15

import 'shape_struct.dart';
import 'typescale_struct.dart';

class TokenSuggestionChip {
  /// md.comp.suggestion-chip.container.height
  static const double containerHeight = 32.00;

  /// md.comp.suggestion-chip.container.shape
  static const ShapeStruct containerShape = ShapeStruct(
    family: 'SHAPE_FAMILY_ROUNDED_CORNERS',
    topLeft: 8.00,
    topRight: 8.00,
    bottomLeft: 8.00,
    bottomRight: 8.00,
  );

  /// md.comp.suggestion-chip.disabled.label-text.opacity
  static const double disabledLabelTextOpacity = 0.38;

  /// md.comp.suggestion-chip.dragged.container.elevation
  static const double draggedContainerElevation = 8.00;

  /// md.comp.suggestion-chip.dragged.state-layer.opacity
  static const double draggedStateLayerOpacity = 0.16;

  /// md.comp.suggestion-chip.elevated.container.elevation
  static const double elevatedContainerElevation = 1.00;

  /// md.comp.suggestion-chip.elevated.disabled.container.elevation
  static const double elevatedDisabledContainerElevation = 0.00;

  /// md.comp.suggestion-chip.elevated.disabled.container.opacity
  static const double elevatedDisabledContainerOpacity = 0.12;

  /// md.comp.suggestion-chip.elevated.focus.container.elevation
  static const double elevatedFocusContainerElevation = 1.00;

  /// md.comp.suggestion-chip.elevated.hover.container.elevation
  static const double elevatedHoverContainerElevation = 3.00;

  /// md.comp.suggestion-chip.elevated.pressed.container.elevation
  static const double elevatedPressedContainerElevation = 1.00;

  /// md.comp.suggestion-chip.flat.container.elevation
  static const double flatContainerElevation = 0.00;

  /// md.comp.suggestion-chip.flat.disabled.outline.opacity
  static const double flatDisabledOutlineOpacity = 0.12;

  /// md.comp.suggestion-chip.flat.outline.width
  static const double flatOutlineWidth = 1.00;

  /// md.comp.suggestion-chip.focus.indicator.outline.offset
  static const double focusIndicatorOutlineOffset = 2.00;

  /// md.comp.suggestion-chip.focus.indicator.thickness
  static const double focusIndicatorThickness = 3.00;

  /// md.comp.suggestion-chip.focus.state-layer.opacity
  static const double focusStateLayerOpacity = 0.10;

  /// md.comp.suggestion-chip.hover.state-layer.opacity
  static const double hoverStateLayerOpacity = 0.08;

  /// md.comp.suggestion-chip.label-text.type
  static const TypescaleStruct labelTextType = TypescaleStruct(
    fontFamily: 'Roboto',
    fontSize: 14.00,
    fontWeight: 500,
    lineHeight: 20.00,
    letterSpacing: 0.10,
  );

  /// md.comp.suggestion-chip.pressed.state-layer.opacity
  static const double pressedStateLayerOpacity = 0.10;

  /// md.comp.suggestion-chip.with-leading-icon.disabled.leading-icon.opacity
  static const double withLeadingIconDisabledLeadingIconOpacity = 0.38;

  /// md.comp.suggestion-chip.with-leading-icon.leading-icon.size
  static const double withLeadingIconLeadingIconSize = 18.00;
}
