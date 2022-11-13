import 'dart:io';

import 'package:flutter/material.dart';
import '../../features/attendance/presentation/screens/subscreens/attendance_screen.dart';
import '../../features/attendance/presentation/screens/subscreens/task_todo_scrren.dart';
import '../../features/attendance/presentation/screens/subscreens/time_sheet_screen.dart';
import '../shared_models/main_screen_model.dart';
import '../utils/app_strings.dart';

const maxSize = Size(1500, 800);
const minSize = Size(850, 900);

List<MainScreens> mainScreens = [
  MainScreens(
      screenName: AppStrings.attendanceScreen,
      screen: const AttendanceScreen(),
      icon: Icons.access_time_rounded),
  MainScreens(
      screenName: AppStrings.taskToDoScreen,
      screen: const TaskToDoScreen(),
      icon: Icons.task_outlined),
  MainScreens(
      screenName: AppStrings.timeSheetScreen,
      screen: const TimeSheetScreen(),
      icon: Icons.calendar_month_outlined),
];

class Constant {

  static bool isWindows() {
    return Platform.isWindows || Platform.isLinux || Platform.isMacOS;
  }

  static Future<bool> isNetworkConnected() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } on SocketException catch (_) {
      return false;
    }
  }
}
