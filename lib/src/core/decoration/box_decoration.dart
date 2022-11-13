
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

BoxDecoration get boxDecoration{
  return BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: AppColors.hint,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
                topRight: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.hint.withOpacity(.1),
                  spreadRadius: .5,
                  blurRadius: 2,
                  offset: const Offset(0, 0),
                ),
              ],
            );
}