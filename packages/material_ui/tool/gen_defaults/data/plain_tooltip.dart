// Copyright 2013 The Flutter Authors.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Version: 38.1.0

import 'shape_struct.dart';

class TokenPlainTooltip {
  /// md.comp.plain-tooltip.container.shape
  static const ShapeStruct containerShape = ShapeStruct(
    family: 'SHAPE_FAMILY_ROUNDED_CORNERS',
    topLeft: 4.00,
    topRight: 4.00,
    bottomLeft: 4.00,
    bottomRight: 4.00,
  );

  /// md.comp.plain-tooltip.supporting-text.type
  static const TypescaleStruct supportingTextType =
      TokenTypescale.bodySmallTracking;
}
