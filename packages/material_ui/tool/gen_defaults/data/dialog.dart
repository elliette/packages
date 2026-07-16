// Copyright 2013 The Flutter Authors.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Version: 38.0.58

import 'color_role.dart';
import 'shape_struct.dart';
import 'typescale.dart';

class TokenDialog {
  /// md.comp.dialog.action.focus.label-text.color
  static const TokenColorRole actionFocusLabelTextColor =
      TokenColorRole.primary;

  /// md.comp.dialog.action.focus.state-layer.color
  static const TokenColorRole actionFocusStateLayerColor =
      TokenColorRole.primary;

  /// md.comp.dialog.action.focus.state-layer.opacity
  static const double actionFocusStateLayerOpacity = 0.10;

  /// md.comp.dialog.action.hover.label-text.color
  static const TokenColorRole actionHoverLabelTextColor =
      TokenColorRole.primary;

  /// md.comp.dialog.action.hover.state-layer.color
  static const TokenColorRole actionHoverStateLayerColor =
      TokenColorRole.primary;

  /// md.comp.dialog.action.hover.state-layer.opacity
  static const double actionHoverStateLayerOpacity = 0.08;

  /// md.comp.dialog.action.label-text.color
  static const TokenColorRole actionLabelTextColor = TokenColorRole.primary;

  /// md.comp.dialog.action.label-text.font
  static const TypescaleStruct actionLabelTextFont =
      TokenTypescale.labelLargeFont;

  /// md.comp.dialog.action.label-text.line-height
  static const TypescaleStruct actionLabelTextLineHeight =
      TokenTypescale.labelLargeLineHeight;

  /// md.comp.dialog.action.label-text.size
  static const TypescaleStruct actionLabelTextSize =
      TokenTypescale.labelLargeSize;

  /// md.comp.dialog.action.label-text.tracking
  static const TypescaleStruct actionLabelTextTracking =
      TokenTypescale.labelLargeTracking;

  /// md.comp.dialog.action.label-text.type
  static const TypescaleStruct actionLabelTextType = TokenTypescale.labelLarge;

  /// md.comp.dialog.action.label-text.weight
  static const TypescaleStruct actionLabelTextWeight =
      TokenTypescale.labelLargeWeight;

  /// md.comp.dialog.action.pressed.label-text.color
  static const TokenColorRole actionPressedLabelTextColor =
      TokenColorRole.primary;

  /// md.comp.dialog.action.pressed.state-layer.color
  static const TokenColorRole actionPressedStateLayerColor =
      TokenColorRole.primary;

  /// md.comp.dialog.action.pressed.state-layer.opacity
  static const double actionPressedStateLayerOpacity = 0.10;

  /// md.comp.dialog.container.color
  static const TokenColorRole containerColor =
      TokenColorRole.surfaceContainerHigh;

  /// md.comp.dialog.container.elevation
  static const double containerElevation = 6.00;

  /// md.comp.dialog.container.shape
  static const ShapeStruct containerShape = ShapeStruct(
    family: 'SHAPE_FAMILY_ROUNDED_CORNERS',
    topLeft: 28.00,
    topRight: 28.00,
    bottomLeft: 28.00,
    bottomRight: 28.00,
  );

  /// md.comp.dialog.headline.color
  static const TokenColorRole headlineColor = TokenColorRole.onSurface;

  /// md.comp.dialog.headline.font
  static const TypescaleStruct headlineFont = TokenTypescale.headlineSmallFont;

  /// md.comp.dialog.headline.line-height
  static const TypescaleStruct headlineLineHeight =
      TokenTypescale.headlineSmallLineHeight;

  /// md.comp.dialog.headline.size
  static const TypescaleStruct headlineSize = TokenTypescale.headlineSmallSize;

  /// md.comp.dialog.headline.tracking
  static const TypescaleStruct headlineTracking =
      TokenTypescale.headlineSmallTracking;

  /// md.comp.dialog.headline.type
  static const TypescaleStruct headlineType = TokenTypescale.headlineSmall;

  /// md.comp.dialog.headline.weight
  static const TypescaleStruct headlineWeight =
      TokenTypescale.headlineSmallWeight;

  /// md.comp.dialog.supporting-text.color
  static const TokenColorRole supportingTextColor =
      TokenColorRole.onSurfaceVariant;

  /// md.comp.dialog.supporting-text.font
  static const TypescaleStruct supportingTextFont =
      TokenTypescale.bodyMediumFont;

  /// md.comp.dialog.supporting-text.line-height
  static const TypescaleStruct supportingTextLineHeight =
      TokenTypescale.bodyMediumLineHeight;

  /// md.comp.dialog.supporting-text.size
  static const TypescaleStruct supportingTextSize =
      TokenTypescale.bodyMediumSize;

  /// md.comp.dialog.supporting-text.tracking
  static const TypescaleStruct supportingTextTracking =
      TokenTypescale.bodyMediumTracking;

  /// md.comp.dialog.supporting-text.type
  static const TypescaleStruct supportingTextType = TokenTypescale.bodyMedium;

  /// md.comp.dialog.supporting-text.weight
  static const TypescaleStruct supportingTextWeight =
      TokenTypescale.bodyMediumWeight;

  /// md.comp.dialog.with-icon.icon.color
  static const TokenColorRole withIconIconColor = TokenColorRole.secondary;

  /// md.comp.dialog.with-icon.icon.size
  static const double withIconIconSize = 24.00;
}
