import 'package:project_template/src/core/shared/shared.dart';

import '../../../../core/shared_models/date_time_model.dart';
import '../../domain/entities/attendance.dart';

class AttendanceUIModel {
  final String date;
  final String? type;
  final String? startTime;
  final String? endTime;
  final String? time;
  final bool? isRamadan;
  final bool? isHoliday;

  AttendanceUIModel(
      {required this.date,
      this.type,
      this.startTime,
      this.endTime,
      this.time,
      this.isRamadan,
      this.isHoliday});
  factory AttendanceUIModel.fromAttendance(Attendance attendance) {
    return AttendanceUIModel(
      date: attendance.date,
      type: attendance.type,
      time: attendance.time,
      startTime: attendance.startTime == null
          ? null
          : DateTimeModel(
                  microsecondsSinceEpoch:
                      attendance.startTime!.microsecondsSinceEpoch)
              .time,
      endTime: attendance.endTime == null
          ? null
          : DateTimeModel(
                  microsecondsSinceEpoch:
                      attendance.endTime!.microsecondsSinceEpoch)
              .time,
      isHoliday: attendance.isHoliday,
      isRamadan: attendance.isRamadan,
    );
  }
}
