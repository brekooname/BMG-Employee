import 'package:flutter/material.dart';

extension MediaQueryValues on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  double get toPadding => MediaQuery.of(this).viewPadding.top;
  double get bottom => MediaQuery.of(this).viewInsets.bottom;
  double get fontSizeBig=>MediaQuery.of(this).size.width*.1;
  double get fontSizeNormal=>MediaQuery.of(this).size.width*.05;
  double get verticalSpace=>MediaQuery.of(this).size.width*.025;
  double get horizontalSpace=>MediaQuery.of(this).size.width*.025;
  double get paddingAll=>MediaQuery.of(this).size.width*.06;
  double get containerPadding=>MediaQuery.of(this).size.width*.03;
  double get margingAll=>MediaQuery.of(this).size.width*.05;
}
