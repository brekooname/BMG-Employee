part of 'attendance_cubit.dart';

abstract class AttendanceState extends Equatable {
  const AttendanceState();

  @override
  List<Object> get props => [];
}

class AttendanceInitial extends AttendanceState {}

class GetPickedDateAttendanceLoading extends AttendanceState {}

class GetPickedDateAttendanceFailure extends AttendanceState {
  final String message;

  const GetPickedDateAttendanceFailure({required this.message});
  @override
  List<Object> get props => [message];
}

class GetPickedDateAttendanceSuccess extends AttendanceState {
  final Attendance attendance;

  const GetPickedDateAttendanceSuccess({required this.attendance});
  @override
  List<Object> get props => [attendance];
}

class GetPickedDateAttendanceProposalLoading extends AttendanceState {}

class GetPickedDateAttendanceProposalFailure extends AttendanceState {
  final String message;

  const GetPickedDateAttendanceProposalFailure({required this.message});
  @override
  List<Object> get props => [message];
}

class GetPickedDateAttendanceProposalSuccess extends AttendanceState {
  final Attendance attendance;

  const GetPickedDateAttendanceProposalSuccess({required this.attendance});
  @override
  List<Object> get props => [attendance];
}

class ExcuteAttendanceActionLoading extends AttendanceState {}

class ExcuteAttendanceActionFailure extends AttendanceState {
  final String message;

  const ExcuteAttendanceActionFailure({required this.message});
  @override
  List<Object> get props => [message];
}

class ExcuteAttendanceActionSuccess extends AttendanceState {
  final Attendance attendance;

  const ExcuteAttendanceActionSuccess({required this.attendance});
  @override
  List<Object> get props => [attendance];
}
