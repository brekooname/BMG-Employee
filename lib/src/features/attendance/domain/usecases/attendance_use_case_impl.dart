import 'package:dartz/dartz.dart';
import 'package:project_template/src/features/attendance/data/models/attendance_model.dart';
import '../../../../core/error/failures.dart';
import '../entities/attendance.dart';
import '../repositories/attendance_repo.dart';
import 'attendance_use_case.dart';

class AttendanceUseCaseImpl implements AttendanceUseCase {
  final AttendanceRepo attendanceRepo;

  AttendanceUseCaseImpl({required this.attendanceRepo});
  @override
  Future<Either<Failure, Attendance>> getPickedAttendance(
      {required String day}) async {
    return await attendanceRepo.getPickedAttendance(day: day);
  }

  @override
  Future<String?> endAttendance(
      {required AttendanceModel attendanceModel}) async {
    return await attendanceRepo.endAttendance(attendanceModel: attendanceModel);
  }

  @override
  Future<Either<Failure, Attendance>> startAttendance(
      {required AttendanceModel attendanceModel}) async {
    return await attendanceRepo.startAttendance(
        attendanceModel: attendanceModel);
  }
}
