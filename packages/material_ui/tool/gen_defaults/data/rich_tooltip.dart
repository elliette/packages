// Copyright 2013 The Flutter Authors.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Version: 38.0.58

import 'color_role.dart';
import 'shape_struct.dart';
import 'typescale.dart';

class TokenRichTooltip {
  /// md.comp.rich-tooltip.action.focus.label-text.color
  static const TokenColorRole actionFocusLabelTextColor =
      TokenColorRole.primary;

  /// md.comp.rich-tooltip.action.focus.state-layer.color
  static const TokenColorRole actionFocusStateLayerColor =
      TokenColorRole.primary;

  /// md.comp.rich-tooltip.action.focus.state-layer.opacity
  static const double actionFocusStateLayerOpacity = 0.10;

  /// md.comp.rich-tooltip.action.hover.label-text.color
  static const TokenColorRole actionHoverLabelTextColor =
      TokenColorRole.primary;

  /// md.comp.rich-tooltip.action.hover.state-layer.color
  static const TokenColorRole actionHoverStateLayerColor =
      TokenColorRole.primary;

  /// md.comp.rich-tooltip.action.hover.state-layer.opacity
  static const double actionHoverStateLayerOpacity = 0.08;

  /// md.comp.rich-tooltip.action.label-text.color
  static const TokenColorRole actionLabelTextColor = TokenColorRole.primary;

  /// md.comp.rich-tooltip.action.label-text.font
  static const TypescaleStruct actionLabelTextFont =
      TokenTypescale.labelLargeFont;

  /// md.comp.rich-tooltip.action.label-text.line-height
  static const TypescaleStruct actionLabelTextLineHeight =
      TokenTypescale.labelLargeLineHeight;

  /// md.comp.rich-tooltip.action.label-text.size
  static const TypescaleStruct actionLabelTextSize =
      TokenTypescale.labelLargeSize;

  /// md.comp.rich-tooltip.action.label-text.tracking
  static const TypescaleStruct actionLabelTextTracking =
      TokenTypescale.labelLargeTracking;

  /// md.comp.rich-tooltip.action.label-text.type
  static const TypescaleStruct actionLabelTextType = TokenTypescale.labelLarge;

  /// md.comp.rich-tooltip.action.label-text.weight
  static const TypescaleStruct actionLabelTextWeight =
      TokenTypescale.labelLargeWeight;

  /// md.comp.rich-tooltip.action.pressed.label-text.color
  static const TokenColorRole actionPressedLabelTextColor =
      TokenColorRole.primary;

  /// md.comp.rich-tooltip.action.pressed.state-layer.color
  static const TokenColorRole actionPressedStateLayerColor =
      TokenColorRole.primary;

  /// md.comp.rich-tooltip.action.pressed.state-layer.opacity
  static const double actionPressedStateLayerOpacity = 0.10;

  /// md.comp.rich-tooltip.container.color
  static const TokenColorRole containerColor = TokenColorRole.surfaceContainer;

  /// md.comp.rich-tooltip.container.elevation
  static const double containerElevation = 3.00;

  /// md.comp.rich-tooltip.container.shadow-color
  static const TokenColorRole containerShadowColor = TokenColorRole.shadow;

  /// md.comp.rich-tooltip.container.shape
  static const ShapeStruct containerShape = ShapeStruct(
    family: 'SHAPE_FAMILY_ROUNDED_CORNERS',
    topLeft: 12.00,
    topRight: 12.00,
    bottomLeft: 12.00,
    bottomRight: 12.00,
  );

  /// md.comp.rich-tooltip.subhead.color
  static const TokenColorRole subheadColor = TokenColorRole.onSurfaceVariant;

  /// md.comp.rich-tooltip.subhead.font
  static const TypescaleStruct subheadFont = TokenTypescale.titleSmallFont;

  /// md.comp.rich-tooltip.subhead.line-height
  static const TypescaleStruct subheadLineHeight =
      TokenTypescale.titleSmallLineHeight;

  /// md.comp.rich-tooltip.subhead.size
  static const TypescaleStruct subheadSize = TokenTypescale.titleSmallSize;

  /// md.comp.rich-tooltip.subhead.tracking
  static const TypescaleStruct subheadTracking =
      TokenTypescale.titleSmallTracking;

  /// md.comp.rich-tooltip.subhead.type
  static const TypescaleStruct subheadType = TokenTypescale.titleSmall;

  /// md.comp.rich-tooltip.subhead.weight
  static const TypescaleStruct subheadWeight = TokenTypescale.titleSmallWeight;

  /// md.comp.rich-tooltip.supporting-text.color
  static const TokenColorRole supportingTextColor =
      TokenColorRole.onSurfaceVariant;

  /// md.comp.rich-tooltip.supporting-text.font
  static const TypescaleStruct supportingTextFont =
      TokenTypescale.bodyMediumFont;

  /// md.comp.rich-tooltip.supporting-text.line-height
  static const TypescaleStruct supportingTextLineHeight =
      TokenTypescale.bodyMediumLineHeight;

  /// md.comp.rich-tooltip.supporting-text.size
  static const TypescaleStruct supportingTextSize =
      TokenTypescale.bodyMediumSize;

  /// md.comp.rich-tooltip.supporting-text.tracking
  static const TypescaleStruct supportingTextTracking =
      TokenTypescale.bodyMediumTracking;

  /// md.comp.rich-tooltip.supporting-text.type
  static const TypescaleStruct supportingTextType = TokenTypescale.bodyMedium;

  /// md.comp.rich-tooltip.supporting-text.weight
  static const TypescaleStruct supportingTextWeight =
      TokenTypescale.bodyMediumWeight;
}
