import 'package:flutter/material.dart';
import 'package:project_template/src/core/utils/media_query_values.dart';

import '../utils/assets_manager.dart';

class CompanyIcon extends StatelessWidget {
  final double iconSizeFromHeight;
  const CompanyIcon({super.key, this.iconSizeFromHeight=.15});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: context.height * .04,
      ),
      child: SizedBox(
          height: context.height * iconSizeFromHeight,
          child: Image.asset(
            ImgAssets.bmgIcon,
          )),
    );
  }
}
