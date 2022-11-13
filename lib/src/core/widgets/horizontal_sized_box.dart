

import 'package:flutter/material.dart';
import 'package:project_template/src/core/utils/media_query_values.dart';

class HorizontalSizedBox extends StatelessWidget {
  final double? height;
  final double? width;
  const HorizontalSizedBox({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width?? context.verticalSpace,
    );
  }
}