// Copyright 2013 The Flutter Authors.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Version: 38.0.59

import 'shape_struct.dart';

class TokenDataTable {
  /// md.comp.data-table.container.shape
  static const ShapeStruct containerShape = ShapeStruct(
    family: 'SHAPE_FAMILY_ROUNDED_CORNERS',
    topLeft: 4.00,
    topRight: 4.00,
    bottomLeft: 4.00,
    bottomRight: 4.00,
  );

  /// md.comp.data-table.footer.container.height
  static const double footerContainerHeight = 52.00;

  /// md.comp.data-table.header.container.height
  static const double headerContainerHeight = 56.00;

  /// md.comp.data-table.outline.width
  static const double outlineWidth = 1.00;

  /// md.comp.data-table.row-item.container.height
  static const double rowItemContainerHeight = 52.00;

  /// md.comp.data-table.row-item.disabled.label-text.opacity
  static const double rowItemDisabledLabelTextOpacity = 0.38;

  /// md.comp.data-table.row-item.outline.width
  static const double rowItemOutlineWidth = 1.00;

  /// md.comp.data-table.row-item.selected.hover.state-layer.opacity
  static const double rowItemSelectedHoverStateLayerOpacity = 0.08;

  /// md.comp.data-table.row-item.unselected.hover.state-layer.opacity
  static const double rowItemUnselectedHoverStateLayerOpacity = 0.08;
}
