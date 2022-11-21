import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/constant.dart';
import '../../data/models/attendance_model.dart';
import '../../domain/entities/attendance.dart';
import '../../domain/usecases/attendance_use_case.dart';

part 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  final AttendanceUseCase attendanceUseCase;
  AttendanceCubit({required this.attendanceUseCase})
      : super(AttendanceInitial());

  init({required String day}) async {
    await getPickedDateAttendance(day: day);
    await getPickedDateProposalAttendance(day: day);
  }

  ///Regular Attendance
  getPickedDateAttendance({required String day}) async {
    emit(GetPickedDateAttendanceLoading());
    final res = await attendanceUseCase.getPickedAttendance(day: day);
    emit(res.fold(
        (failure) => GetPickedDateAttendanceFailure(
            message: Constant.mapFailureToString(failure)),
        (attendance) =>
            GetPickedDateAttendanceSuccess(attendance: attendance)));
  }

  startAttendance({required AttendanceModel attendanceModel}) async {
    emit(GetPickedDateAttendanceLoading());
    final res = await attendanceUseCase.startAttendance(
        attendanceModel: attendanceModel);
    emit(res.fold(
        (failure) => GetPickedDateAttendanceFailure(
            message: Constant.mapFailureToString(failure)),
        (attendance) =>
            GetPickedDateAttendanceSuccess(attendance: attendance)));
  }

  endAttendance({required AttendanceModel attendanceModel}) async {
    emit(ExcuteAttendanceActionLoading());
    final res =
        await attendanceUseCase.endAttendance(attendanceModel: attendanceModel);
    if (res == null) {
      emit(GetPickedDateAttendanceSuccess(attendance: attendanceModel));
    } else {
      emit(GetPickedDateAttendanceFailure(message: res));
    }
  }

  ///Proposal Attendance
  getPickedDateProposalAttendance({required String day}) async {
    emit(GetPickedDateAttendanceProposalLoading());
    final res = await attendanceUseCase.getPickedAttendance(day: day);
    emit(res.fold(
        (failure) => GetPickedDateAttendanceProposalFailure(
            message: Constant.mapFailureToString(failure)),
        (attendance) =>
            GetPickedDateAttendanceProposalSuccess(attendance: attendance)));
  }
}
