// Copyright 2013 The Flutter Authors.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Version: 38.1.0

import 'shape_struct.dart';
import 'typescale_struct.dart';

class TokenFilledTextField {
  /// md.comp.filled-text-field.active-indicator.height
  static const double activeIndicatorHeight = 1.00;

  /// md.comp.filled-text-field.container.shape
  static const ShapeStruct containerShape = ShapeStruct(
    family: 'SHAPE_FAMILY_ROUNDED_CORNERS',
    topLeft: 4.00,
    topRight: 4.00,
    bottomLeft: 0.00,
    bottomRight: 0.00,
  );

  /// md.comp.filled-text-field.disabled.active-indicator.height
  static const double disabledActiveIndicatorHeight = 1.00;

  /// md.comp.filled-text-field.disabled.active-indicator.opacity
  static const double disabledActiveIndicatorOpacity = 0.38;

  /// md.comp.filled-text-field.disabled.container.opacity
  static const double disabledContainerOpacity = 0.04;

  /// md.comp.filled-text-field.disabled.input-text.opacity
  static const double disabledInputTextOpacity = 0.38;

  /// md.comp.filled-text-field.disabled.label-text.opacity
  static const double disabledLabelTextOpacity = 0.38;

  /// md.comp.filled-text-field.disabled.leading-icon.opacity
  static const double disabledLeadingIconOpacity = 0.38;

  /// md.comp.filled-text-field.disabled.supporting-text.opacity
  static const double disabledSupportingTextOpacity = 0.38;

  /// md.comp.filled-text-field.disabled.trailing-icon.opacity
  static const double disabledTrailingIconOpacity = 0.38;

  /// md.comp.filled-text-field.error.hover.state-layer.opacity
  static const double errorHoverStateLayerOpacity = 0.08;

  /// md.comp.filled-text-field.focus.active-indicator.height
  static const double focusActiveIndicatorHeight = 2.00;

  /// md.comp.filled-text-field.focus.active-indicator.thickness
  static const double focusActiveIndicatorThickness = 3.00;

  /// md.comp.filled-text-field.hover.active-indicator.height
  static const double hoverActiveIndicatorHeight = 1.00;

  /// md.comp.filled-text-field.hover.state-layer.opacity
  static const double hoverStateLayerOpacity = 0.08;

  /// md.comp.filled-text-field.input-text.type
  static const TypescaleStruct inputTextType = TypescaleStruct(
    fontFamily: 'Roboto',
    fontSize: 16.00,
    fontWeight: 400,
    lineHeight: 24.00,
    letterSpacing: 0.50,
  );

  /// md.comp.filled-text-field.label-text.type
  static const TypescaleStruct labelTextType = TypescaleStruct(
    fontFamily: 'Roboto',
    fontSize: 16.00,
    fontWeight: 400,
    lineHeight: 24.00,
    letterSpacing: 0.50,
  );

  /// md.comp.filled-text-field.leading-icon.size
  static const double leadingIconSize = 24.00;

  /// md.comp.filled-text-field.supporting-text.type
  static const TypescaleStruct supportingTextType = TypescaleStruct(
    fontFamily: 'Roboto',
    fontSize: 12.00,
    fontWeight: 400,
    lineHeight: 16.00,
    letterSpacing: 0.40,
  );

  /// md.comp.filled-text-field.trailing-icon.size
  static const double trailingIconSize = 24.00;
}
