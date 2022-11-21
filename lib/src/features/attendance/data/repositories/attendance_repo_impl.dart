import 'package:dartz/dartz.dart';
import 'package:project_template/src/features/attendance/data/models/attendance_model.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/app_strings.dart';
import '../../domain/entities/attendance.dart';
import '../../domain/repositories/attendance_repo.dart';
import '../datasources/attendance_data_source.dart';

class AttendanceRepoImpl implements AttendanceRepo {
  final AttendanceDataSourceImpl attendanceDataSourceImpl;
  final NetworkInfo networkInfo;

  AttendanceRepoImpl(
      {required this.attendanceDataSourceImpl, required this.networkInfo});
  @override
  Future<Either<Failure, Attendance>> getPickedAttendance(
      {required String day}) async {
    if (await networkInfo.isConnected) {
      final res = await attendanceDataSourceImpl.getPickedAttendance(day: day);
      if (res == null) {
        return left(CacheFailure(message: AppStrings.noAttendanceAvailable));
      }
      return right(res);
    }
    return left(ServerFailure(message: AppStrings.serverFailure));
  }

  @override
  Future<String?> endAttendance(
      {required AttendanceModel attendanceModel}) async {
    if (await networkInfo.isConnected) {
      await attendanceDataSourceImpl.endAttendance(
          attendanceModel: attendanceModel);
      return null;
    }
    return AppStrings.serverFailure;
  }

  @override
  Future<Either<Failure, Attendance>> startAttendance(
      {required AttendanceModel attendanceModel}) async {
    if (await networkInfo.isConnected) {
      final attendance = await attendanceDataSourceImpl.startAttendance(
          attendanceModel: attendanceModel);
      return right(attendance);
    }
    return left(ServerFailure(message: AppStrings.serverFailure));
  }
}
