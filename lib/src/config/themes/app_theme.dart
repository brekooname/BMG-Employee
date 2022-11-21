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
        headlineLarge:  TextStyle(
          color: AppColors.black,
          fontSize: Constant.isWindows()?35:25, 
          fontWeight: FontWeight.bold,
        ),
        headline1: TextStyle(
          color: AppColors.black,
          fontWeight: FontWeight.bold,
        ),
        headline2: TextStyle(
          fontSize: Constant.isWindows()?30:20,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        headline3: TextStyle(
          fontSize: Constant.isWindows()?20:15,
           color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        headline4: TextStyle(
          fontSize: Constant.isWindows()?15:9,
          color: AppColors.black,
          fontWeight: FontWeight.bold
        ),
        headline5: TextStyle(
          color: AppColors.black,
         fontSize: Constant.isWindows()?15:8,
          fontWeight: FontWeight.bold,
        ),
        headline6: TextStyle(
          color: AppColors.black,
        ),
      ));
}
