import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/attendance_model.dart';
import '../entities/attendance.dart';

abstract class AttendanceRepo {
  Future<Either<Failure, Attendance>> getPickedAttendance(
      {required String day});
  Future<Either<Failure, Attendance>> startAttendance(
      {required AttendanceModel attendanceModel});
  Future<String?> endAttendance({required AttendanceModel attendanceModel});
}
