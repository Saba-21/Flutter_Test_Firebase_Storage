import 'package:flutter/cupertino.dart';

const EdgeInsetsGeometry sectionListItemPadding =
    EdgeInsets.only(top: 10, bottom: 10);
const EdgeInsetsGeometry sectionTitlePadding =
    EdgeInsets.only(left: 8, top: 16, bottom: 16);
const EdgeInsetsGeometry sectionListItemCardPadding = EdgeInsets.all(4);
const ShapeBorder sectionListItemShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(16),
  ),
);
const ShapeBorder bottomSheetShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(20.0),
    topRight: Radius.circular(20.0),
  ),
);