// Copyright 2013 The Flutter Authors.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Version: 38.0.14

import 'shape_struct.dart';
import 'typescale_struct.dart';

class TokenTimeInput {
  /// md.comp.time-input.container.elevation
  static const double containerElevation = 6.00;

  /// md.comp.time-input.container.shape
  static const ShapeStruct containerShape = ShapeStruct(
    family: 'SHAPE_FAMILY_ROUNDED_CORNERS',
    topLeft: 28.00,
    topRight: 28.00,
    bottomLeft: 28.00,
    bottomRight: 28.00,
  );

  /// md.comp.time-input.focus.indicator.outline.offset
  static const double focusIndicatorOutlineOffset = 2.00;

  /// md.comp.time-input.focus.indicator.thickness
  static const double focusIndicatorThickness = 3.00;

  /// md.comp.time-input.headline.type
  static const TypescaleStruct headlineType = TypescaleStruct(
    fontFamily: 'Roboto',
    fontSize: 12.00,
    fontWeight: 500,
    lineHeight: 16.00,
    letterSpacing: 0.50,
  );

  /// md.comp.time-input.period-selector.container.height
  static const double periodSelectorContainerHeight = 72.00;

  /// md.comp.time-input.period-selector.container.shape
  static const ShapeStruct periodSelectorContainerShape = ShapeStruct(
    family: 'SHAPE_FAMILY_ROUNDED_CORNERS',
    topLeft: 8.00,
    topRight: 8.00,
    bottomLeft: 8.00,
    bottomRight: 8.00,
  );

  /// md.comp.time-input.period-selector.container.width
  static const double periodSelectorContainerWidth = 52.00;

  /// md.comp.time-input.period-selector.focus.state-layer.opacity
  static const double periodSelectorFocusStateLayerOpacity = 0.10;

  /// md.comp.time-input.period-selector.hover.state-layer.opacity
  static const double periodSelectorHoverStateLayerOpacity = 0.08;

  /// md.comp.time-input.period-selector.label-text.type
  static const TypescaleStruct periodSelectorLabelTextType = TypescaleStruct(
    fontFamily: 'Roboto',
    fontSize: 16.00,
    fontWeight: 500,
    lineHeight: 24.00,
    letterSpacing: 0.15,
  );

  /// md.comp.time-input.period-selector.outline.width
  static const double periodSelectorOutlineWidth = 1.00;

  /// md.comp.time-input.period-selector.pressed.state-layer.opacity
  static const double periodSelectorPressedStateLayerOpacity = 0.10;

  /// md.comp.time-input.time-input-field.container.height
  static const double timeInputFieldContainerHeight = 72.00;

  /// md.comp.time-input.time-input-field.container.shape
  static const ShapeStruct timeInputFieldContainerShape = ShapeStruct(
    family: 'SHAPE_FAMILY_ROUNDED_CORNERS',
    topLeft: 8.00,
    topRight: 8.00,
    bottomLeft: 8.00,
    bottomRight: 8.00,
  );

  /// md.comp.time-input.time-input-field.container.width
  static const double timeInputFieldContainerWidth = 96.00;

  /// md.comp.time-input.time-input-field.focus.outline.width
  static const double timeInputFieldFocusOutlineWidth = 2.00;

  /// md.comp.time-input.time-input-field.hover.state-layer.opacity
  static const double timeInputFieldHoverStateLayerOpacity = 0.08;

  /// md.comp.time-input.time-input-field.label-text.type
  static const TypescaleStruct timeInputFieldLabelTextType = TypescaleStruct(
    fontFamily: 'Roboto',
    fontSize: 45.00,
    fontWeight: 400,
    lineHeight: 52.00,
    letterSpacing: 0.00,
  );

  /// md.comp.time-input.time-input-field.separator.type
  static const TypescaleStruct timeInputFieldSeparatorType = TypescaleStruct(
    fontFamily: 'Roboto',
    fontSize: 57.00,
    fontWeight: 400,
    lineHeight: 64.00,
    letterSpacing: -0.25,
  );

  /// md.comp.time-input.time-input-field.supporting-text.type
  static const TypescaleStruct timeInputFieldSupportingTextType =
      TypescaleStruct(
        fontFamily: 'Roboto',
        fontSize: 12.00,
        fontWeight: 400,
        lineHeight: 16.00,
        letterSpacing: 0.40,
      );
}
