import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../features/attendance/presentation/screens/subscreens/attendance_proposal_screen.dart';
import '../../features/attendance/presentation/screens/subscreens/attendance_screen.dart';
import '../../features/attendance/presentation/screens/subscreens/task_todo_scrren.dart';
import '../../features/attendance/presentation/screens/subscreens/time_sheet_screen.dart';
import '../../features/attendance/presentation/ui_models/attendance_ui_model.dart';
import '../error/failures.dart';
import '../shared_models/main_screen_model.dart';
import '../utils/app_strings.dart';

const maxSize = Size(1500, 800);
const minSize = Size(850, 900);

enum AttendanceAction {
  start(AppStrings.start),
  end(AppStrings.end),
  noAction(AppStrings.noAction);
  // startFromHome(AppStrings.startFromHome),
  // endFromHome(AppStrings.endFromHome),
  // annualVacation(AppStrings.annualVacation),
  // sickLeave(AppStrings.sickLeave);

  const AttendanceAction(String action);
}

String getRightAction(AttendanceUIModel attendance) {
  if (attendance.endTime == null && attendance.time == null) {
    return AttendanceAction.end.name;
  }
  if (attendance.time != null) AttendanceAction.noAction;
  return AttendanceAction.start.name;
}

String getTime({
  required DateTime startTime,
  required DateTime endTime,
}) {
  final difference = endTime.difference(startTime);
  int mins=difference.inMinutes;
  int hr=(mins/60).floor();
  int min=(mins%60);
  String hrStr=hr.toString();
  String minStr=min.toString();
  if (hrStr.length == 1) {
    hrStr = '0$hr';
  }
  if (minStr.length == 1) {
    minStr = '0$min';
  }

  return '$hrStr:$minStr';
}

List<MainScreens> mainScreens = [
  if (Constant.isWindows())
    MainScreens(
        screenName: AppStrings.attendanceScreen,
        screen: const AttendanceScreen(),
        icon: Icons.access_time_rounded),
  MainScreens(
      screenName: AppStrings.attendancePrposalScreen,
      screen: const AttendanceProposalScreen(),
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

  static String get greeting {
    final now = TimeOfDay.now().hour;
    String greetingString = "";
    if (now >= 6 && now < 10) {
      greetingString = AppStrings.morning;
    } else if (now >= 10 && now < 4) {
      greetingString = AppStrings.afternoon;
    } else {
      greetingString = AppStrings.evening;
    }
    return greetingString;
  }

  static String mapFailureToString(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return failure.props.first.toString();
      case CacheFailure:
        return failure.props.first.toString();
      default:
        return AppStrings.unexpectedFailure;
    }
  }

  static Map<int, FlexColumnWidth> columnWidthsWithEnd() {
    return const {
      0: FlexColumnWidth(1.5),
      1: FlexColumnWidth(.5),
      2: FlexColumnWidth(.5),
      3: FlexColumnWidth(.5),
      4: FlexColumnWidth(.6),
      5: FlexColumnWidth(.6),
    };
  }

  static Map<int, FlexColumnWidth> columnWidthsWithoutEnd() {
    return const {
      0: FlexColumnWidth(1.5),
      1: FlexColumnWidth(1),
      2: FlexColumnWidth(.5),
      3: FlexColumnWidth(.6),
      4: FlexColumnWidth(.6),
    };
  }
}
