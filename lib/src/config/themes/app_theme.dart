import 'package:flutter/material.dart';
import '../../core/constant/constant.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_strings.dart';

ThemeData appTheme() {
  return ThemeData(
      primaryColor: AppColors.primary,
      hintColor: AppColors.hint,
      scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
      brightness: Brightness.light,
      // primarySwatch: AppColors.primary,
      fontFamily: AppStrings.fontFamily,
      ///TextTheme
      textTheme: TextTheme(
        headlineLarge: const TextStyle(
          // color: AppColors.black,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        headline1: TextStyle(
          color: AppColors.black,
          fontWeight: FontWeight.bold,
        ),
        headline2: TextStyle(
          fontSize: Constant.isWindows()?30:20,
          fontWeight: FontWeight.bold,
        ),
        headline5: TextStyle(
          color: AppColors.black,
          fontWeight: FontWeight.bold,
        ),
        headline6: TextStyle(
          color: AppColors.black,
        ),
      ));
}
