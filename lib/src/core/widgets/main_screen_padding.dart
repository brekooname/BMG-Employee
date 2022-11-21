import 'package:flutter/material.dart';
import 'package:project_template/src/core/utils/media_query_values.dart';

import '../constant/constant.dart';

class MainScreenPadding extends StatelessWidget {
  final List<Widget> children;
  const MainScreenPadding({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: (context.width >= minSize.width)
            ? EdgeInsets.all(context.paddingAllWindows)
            : EdgeInsets.all(context.paddingAll),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: children,
        ),
      ),
    );
  }
}
