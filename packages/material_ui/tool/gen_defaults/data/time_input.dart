// Copyright 2013 The Flutter Authors.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Version: 38.0.58

import 'color_role.dart';
import 'shape_struct.dart';
import 'typescale.dart';

class TokenTimeInput {
  /// md.comp.time-input.container.color
  static const TokenColorRole containerColor =
      TokenColorRole.surfaceContainerHigh;

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

  /// md.comp.time-input.focus.indicator.color
  static const TokenColorRole focusIndicatorColor = TokenColorRole.secondary;

  /// md.comp.time-input.focus.indicator.outline.offset
  static const double focusIndicatorOutlineOffset = 2.00;

  /// md.comp.time-input.focus.indicator.thickness
  static const double focusIndicatorThickness = 3.00;

  /// md.comp.time-input.headline.color
  static const TokenColorRole headlineColor = TokenColorRole.onSurfaceVariant;

  /// md.comp.time-input.headline.font
  static const TypescaleStruct headlineFont = TokenTypescale.labelMediumFont;

  /// md.comp.time-input.headline.line-height
  static const TypescaleStruct headlineLineHeight =
      TokenTypescale.labelMediumLineHeight;

  /// md.comp.time-input.headline.size
  static const TypescaleStruct headlineSize = TokenTypescale.labelMediumSize;

  /// md.comp.time-input.headline.tracking
  static const TypescaleStruct headlineTracking =
      TokenTypescale.labelMediumTracking;

  /// md.comp.time-input.headline.type
  static const TypescaleStruct headlineType = TokenTypescale.labelMedium;

  /// md.comp.time-input.headline.weight
  static const TypescaleStruct headlineWeight =
      TokenTypescale.labelMediumWeight;

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

  /// md.comp.time-input.period-selector.label-text.font
  static const TypescaleStruct periodSelectorLabelTextFont =
      TokenTypescale.titleMediumFont;

  /// md.comp.time-input.period-selector.label-text.line-height
  static const TypescaleStruct periodSelectorLabelTextLineHeight =
      TokenTypescale.titleMediumLineHeight;

  /// md.comp.time-input.period-selector.label-text.size
  static const TypescaleStruct periodSelectorLabelTextSize =
      TokenTypescale.titleMediumSize;

  /// md.comp.time-input.period-selector.label-text.tracking
  static const TypescaleStruct periodSelectorLabelTextTracking =
      TokenTypescale.titleMediumTracking;

  /// md.comp.time-input.period-selector.label-text.type
  static const TypescaleStruct periodSelectorLabelTextType =
      TokenTypescale.titleMedium;

  /// md.comp.time-input.period-selector.label-text.weight
  static const TypescaleStruct periodSelectorLabelTextWeight =
      TokenTypescale.titleMediumWeight;

  /// md.comp.time-input.period-selector.outline.color
  static const TokenColorRole periodSelectorOutlineColor =
      TokenColorRole.outline;

  /// md.comp.time-input.period-selector.outline.width
  static const double periodSelectorOutlineWidth = 1.00;

  /// md.comp.time-input.period-selector.pressed.state-layer.opacity
  static const double periodSelectorPressedStateLayerOpacity = 0.10;

  /// md.comp.time-input.period-selector.selected.container.color
  static const TokenColorRole periodSelectorSelectedContainerColor =
      TokenColorRole.tertiaryContainer;

  /// md.comp.time-input.period-selector.selected.focus.label-text.color
  static const TokenColorRole periodSelectorSelectedFocusLabelTextColor =
      TokenColorRole.onTertiaryContainer;

  /// md.comp.time-input.period-selector.selected.focus.state-layer.color
  static const TokenColorRole periodSelectorSelectedFocusStateLayerColor =
      TokenColorRole.onTertiaryContainer;

  /// md.comp.time-input.period-selector.selected.hover.label-text.color
  static const TokenColorRole periodSelectorSelectedHoverLabelTextColor =
      TokenColorRole.onTertiaryContainer;

  /// md.comp.time-input.period-selector.selected.hover.state-layer.color
  static const TokenColorRole periodSelectorSelectedHoverStateLayerColor =
      TokenColorRole.onTertiaryContainer;

  /// md.comp.time-input.period-selector.selected.label-text.color
  static const TokenColorRole periodSelectorSelectedLabelTextColor =
      TokenColorRole.onTertiaryContainer;

  /// md.comp.time-input.period-selector.selected.pressed.label-text.color
  static const TokenColorRole periodSelectorSelectedPressedLabelTextColor =
      TokenColorRole.onTertiaryContainer;

  /// md.comp.time-input.period-selector.selected.pressed.state-layer.color
  static const TokenColorRole periodSelectorSelectedPressedStateLayerColor =
      TokenColorRole.onTertiaryContainer;

  /// md.comp.time-input.period-selector.unselected.focus.label-text.color
  static const TokenColorRole periodSelectorUnselectedFocusLabelTextColor =
      TokenColorRole.onSurfaceVariant;

  /// md.comp.time-input.period-selector.unselected.focus.state-layer.color
  static const TokenColorRole periodSelectorUnselectedFocusStateLayerColor =
      TokenColorRole.onSurfaceVariant;

  /// md.comp.time-input.period-selector.unselected.hover.label-text.color
  static const TokenColorRole periodSelectorUnselectedHoverLabelTextColor =
      TokenColorRole.onSurfaceVariant;

  /// md.comp.time-input.period-selector.unselected.hover.state-layer.color
  static const TokenColorRole periodSelectorUnselectedHoverStateLayerColor =
      TokenColorRole.onSurfaceVariant;

  /// md.comp.time-input.period-selector.unselected.label-text.color
  static const TokenColorRole periodSelectorUnselectedLabelTextColor =
      TokenColorRole.onSurfaceVariant;

  /// md.comp.time-input.period-selector.unselected.pressed.label-text.color
  static const TokenColorRole periodSelectorUnselectedPressedLabelTextColor =
      TokenColorRole.onSurfaceVariant;

  /// md.comp.time-input.period-selector.unselected.pressed.state-layer.color
  static const TokenColorRole periodSelectorUnselectedPressedStateLayerColor =
      TokenColorRole.onSurfaceVariant;

  /// md.comp.time-input.time-input-field.container.color
  static const TokenColorRole timeInputFieldContainerColor =
      TokenColorRole.surfaceContainerHighest;

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

  /// md.comp.time-input.time-input-field.focus.container.color
  static const TokenColorRole timeInputFieldFocusContainerColor =
      TokenColorRole.primaryContainer;

  /// md.comp.time-input.time-input-field.focus.label-text.color
  static const TokenColorRole timeInputFieldFocusLabelTextColor =
      TokenColorRole.onPrimaryContainer;

  /// md.comp.time-input.time-input-field.focus.outline.color
  static const TokenColorRole timeInputFieldFocusOutlineColor =
      TokenColorRole.primary;

  /// md.comp.time-input.time-input-field.focus.outline.width
  static const double timeInputFieldFocusOutlineWidth = 2.00;

  /// md.comp.time-input.time-input-field.hover.label-text.color
  static const TokenColorRole timeInputFieldHoverLabelTextColor =
      TokenColorRole.onSurface;

  /// md.comp.time-input.time-input-field.hover.state-layer.color
  static const TokenColorRole timeInputFieldHoverStateLayerColor =
      TokenColorRole.onSurface;

  /// md.comp.time-input.time-input-field.hover.state-layer.opacity
  static const double timeInputFieldHoverStateLayerOpacity = 0.08;

  /// md.comp.time-input.time-input-field.label-text.color
  static const TokenColorRole timeInputFieldLabelTextColor =
      TokenColorRole.onSurface;

  /// md.comp.time-input.time-input-field.label-text.font
  static const TypescaleStruct timeInputFieldLabelTextFont =
      TokenTypescale.displayMediumFont;

  /// md.comp.time-input.time-input-field.label-text.line-height
  static const TypescaleStruct timeInputFieldLabelTextLineHeight =
      TokenTypescale.displayMediumLineHeight;

  /// md.comp.time-input.time-input-field.label-text.size
  static const TypescaleStruct timeInputFieldLabelTextSize =
      TokenTypescale.displayMediumSize;

  /// md.comp.time-input.time-input-field.label-text.tracking
  static const TypescaleStruct timeInputFieldLabelTextTracking =
      TokenTypescale.displayMediumTracking;

  /// md.comp.time-input.time-input-field.label-text.type
  static const TypescaleStruct timeInputFieldLabelTextType =
      TokenTypescale.displayMedium;

  /// md.comp.time-input.time-input-field.label-text.weight
  static const TypescaleStruct timeInputFieldLabelTextWeight =
      TokenTypescale.displayMediumWeight;

  /// md.comp.time-input.time-input-field.separator.color
  static const TokenColorRole timeInputFieldSeparatorColor =
      TokenColorRole.onSurface;

  /// md.comp.time-input.time-input-field.separator.font
  static const TypescaleStruct timeInputFieldSeparatorFont =
      TokenTypescale.displayLargeFont;

  /// md.comp.time-input.time-input-field.separator.line-height
  static const TypescaleStruct timeInputFieldSeparatorLineHeight =
      TokenTypescale.displayLargeLineHeight;

  /// md.comp.time-input.time-input-field.separator.size
  static const TypescaleStruct timeInputFieldSeparatorSize =
      TokenTypescale.displayLargeSize;

  /// md.comp.time-input.time-input-field.separator.tracking
  static const TypescaleStruct timeInputFieldSeparatorTracking =
      TokenTypescale.displayLargeTracking;

  /// md.comp.time-input.time-input-field.separator.type
  static const TypescaleStruct timeInputFieldSeparatorType =
      TokenTypescale.displayLarge;

  /// md.comp.time-input.time-input-field.separator.weight
  static const TypescaleStruct timeInputFieldSeparatorWeight =
      TokenTypescale.displayLargeWeight;

  /// md.comp.time-input.time-input-field.supporting-text.color
  static const TokenColorRole timeInputFieldSupportingTextColor =
      TokenColorRole.onSurfaceVariant;

  /// md.comp.time-input.time-input-field.supporting-text.font
  static const TypescaleStruct timeInputFieldSupportingTextFont =
      TokenTypescale.bodySmallFont;

  /// md.comp.time-input.time-input-field.supporting-text.line-height
  static const TypescaleStruct timeInputFieldSupportingTextLineHeight =
      TokenTypescale.bodySmallLineHeight;

  /// md.comp.time-input.time-input-field.supporting-text.size
  static const TypescaleStruct timeInputFieldSupportingTextSize =
      TokenTypescale.bodySmallSize;

  /// md.comp.time-input.time-input-field.supporting-text.tracking
  static const TypescaleStruct timeInputFieldSupportingTextTracking =
      TokenTypescale.bodySmallTracking;

  /// md.comp.time-input.time-input-field.supporting-text.type
  static const TypescaleStruct timeInputFieldSupportingTextType =
      TokenTypescale.bodySmall;

  /// md.comp.time-input.time-input-field.supporting-text.weight
  static const TypescaleStruct timeInputFieldSupportingTextWeight =
      TokenTypescale.bodySmallWeight;
}
