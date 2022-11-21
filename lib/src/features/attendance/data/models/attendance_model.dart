import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/attendance.dart';
part 'attendance_model.g.dart';

@JsonSerializable()
class AttendanceModel extends Attendance {
  AttendanceModel(
      {required super.id,
      required super.date,
      required super.userCode,
      super.time,
      super.type,
      super.startTime,
      super.endTime,
      super.isRamadan,
      super.isHoliday});

  factory AttendanceModel.fromJson(String id, Map<String, dynamic> json) =>
      _$AttendanceModelFromJson(id, json);
  Map<String, dynamic> toJson() => _$AttendanceModelToJson(this);

  factory AttendanceModel.fromAttendance(Attendance attendance) =>
      AttendanceModel(
        id: attendance.id,
        date: attendance.date,
        userCode: attendance.userCode,
        startTime: attendance.startTime,
        endTime: attendance.endTime,
        time: attendance.time,
        type: attendance.type,
        isHoliday: attendance.isHoliday,
        isRamadan: attendance.isRamadan,
      );
}
