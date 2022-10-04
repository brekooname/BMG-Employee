

import 'package:flutter/material.dart';
import 'package:project_template/src/core/utils/media_query_values.dart';

class VerticalSizedBox extends StatelessWidget {
  final double? height;
  final double? width;
  const VerticalSizedBox({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height?? context.verticalSpace,
      width: width,
    );
  }
}