import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:project_template/src/core/firebase/firebase_firestore_repository.dart';
import 'package:project_template/src/core/utils/app_dialogs.dart';
import 'package:project_template/src/core/utils/media_query_values.dart';
import 'package:project_template/src/features/attendance/data/datasources/attendance_data_source.dart';
import 'package:project_template/src/features/attendance/data/models/attendance_model.dart';
import '../../../../../core/constant/constant.dart';
import '../../../../../core/decoration/box_decoration.dart';
import '../../../../../core/shared/shared.dart';
import '../../../../../core/shared_models/date_time_model.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/widgets/regular_button.dart';
import '../../../../../core/widgets/reloading_widget.dart';
import '../../../../../core/widgets/vertical_sized_box.dart';
import '../../cubit/attendance_cubit.dart';
import '../../ui_models/attendance_ui_model.dart';
import '../../widgets/attendance_row.dart';
import '../../widgets/attendance_table_header.dart';
import '../../widgets/vacations_box.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  int? _date;
  int? _time;

  bool _isHoliday = false;
  bool _holidayChanged = false;

  AttendanceAction? availableAction;

  String get date {
    return DateTimeModel(microsecondsSinceEpoch: _date!).date;
  }

  String get time {
    return DateTimeModel(microsecondsSinceEpoch: _time!).time;
  }

  bool get isRamadan {
    return HijriCalendar.fromDate(DateTime.fromMicrosecondsSinceEpoch(_date!))
            .hMonth ==
        9;
  }

  @override
  void initState() {
    _date ??= DateTime.now().microsecondsSinceEpoch;
    _time ??= DateTime.now().microsecondsSinceEpoch;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final attendanceCubit = BlocProvider.of<AttendanceCubit>(context);
    return BlocConsumer<AttendanceCubit, AttendanceState>(
      listener: (context, state) {
        if (state is GetPickedDateAttendanceFailure) {
          AppDialogs.appSnackBar(context: context, text: state.message);
        }
      },
      buildWhen: (previous, current) {
        return current is GetPickedDateAttendanceFailure ||
            current is GetPickedDateAttendanceLoading ||
            current is GetPickedDateAttendanceSuccess;
      },
      builder: (context, state) {
        return Column(children: [
          Text(
            // greeting,
            Constant.greeting,
            style: TextStyle(
              fontSize: context.width * .05,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            currentUser!.userName!,
            style: TextStyle(
              fontSize: context.width * .06,
              fontWeight: FontWeight.w700,
            ),
          ),
          const VerticalSizedBox(),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              VacationBox(
                  vacation: AppStrings.annualVacation,
                  vacationLeft: currentUser!.userAnnualVacation ?? 0),
              VacationBox(
                  vacation: AppStrings.sickLeave,
                  vacationLeft: currentUser!.userSicknessLeave ?? 0),
            ],
          ),
          const VerticalSizedBox(),
          Container(
            decoration: boxDecoration,
            padding: EdgeInsets.all(context.containerPadding),
            margin: EdgeInsets.symmetric(horizontal: context.margingAll),
            child: Column(
              children: [
                TextButton(
                    onPressed: null,
                    child: Text(date,
                        style: textTheme.headline2!
                            .copyWith(color: Theme.of(context).primaryColor))),
                TextButton(
                    onPressed: null,
                    child: Text(time,
                        style: textTheme.headline2!
                            .copyWith(color: Theme.of(context).primaryColor))),
                Divider(
                  color: Colors.black,
                  thickness: Constant.isWindows() ? 0.5 : .8,
                ),
                CheckboxListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: context.paddingAll),
                  value: (state is GetPickedDateAttendanceSuccess &&
                          state.attendance.isHoliday != null &&
                          !_holidayChanged)
                      ? state.attendance.isHoliday
                      : _isHoliday,
                  onChanged: (newval) async {
                    _holidayChanged = true;
                    setState(() {
                      _isHoliday = newval!;
                    });
                  },
                  title: Text(AppStrings.isHoliday,
                      style:
                          textTheme.headline3!.copyWith(color: Colors.black)),
                ),
              ],
            ),
          ),
          const VerticalSizedBox(),
          if (state is GetPickedDateAttendanceSuccess)
            RegularButton(
                text: getRightAction(
                    AttendanceUIModel.fromAttendance(state.attendance)),
                onPressed: state.attendance.time != null
                    ? null
                    : () async {
                        ///ToDo end function
                        ///check for isHoliday with _holidayChanged
                        ///add time "difference"
                        final attendance = state.attendance;
                        attendance.endTime =
                            DateTime.fromMicrosecondsSinceEpoch(_time!);
                        attendance.isRamadan = isRamadan;
                        attendance.isHoliday =
                            _holidayChanged ? _isHoliday : attendance.isHoliday;
                        attendance.time = getTime(
                            startTime: attendance.startTime!,
                            endTime: attendance.endTime!);
                        await attendanceCubit.endAttendance(
                            attendanceModel:
                                AttendanceModel.fromAttendance(attendance));
                      }),
          if (state is GetPickedDateAttendanceFailure &&
              state.message != AppStrings.serverFailure)
            RegularButton(
                text: AttendanceAction.start.name,
                onPressed: () async {
                  ///ToDo start function
                  final attendanceModel = AttendanceModel(
                    id: "",
                    date: date,
                    userCode: currentUser!.userCode,
                    startTime: DateTime.fromMicrosecondsSinceEpoch(_time!),
                    isRamadan: isRamadan,
                    isHoliday: _isHoliday,
                  );
                  await attendanceCubit.startAttendance(
                      attendanceModel: attendanceModel);
                }),
          if (state is GetPickedDateAttendanceFailure &&
              state.message == AppStrings.serverFailure)
            IconButton(
                onPressed: () async {
                  await attendanceCubit.getPickedDateAttendance(day: date);
                },
                icon: const Icon(Icons.replay_outlined)),
          if (state is GetPickedDateAttendanceLoading) const ReloadingWidget(),
          const VerticalSizedBox(),
          if (state is GetPickedDateAttendanceFailure)
            Text(
              AppStrings.noAttendanceAvailable,
              style: textTheme.headline2!.copyWith(color: AppColors.hint),
            ),
          if (state is GetPickedDateAttendanceSuccess)
            Column(
              children: [
                const AttendanceHeaderRow(),
                AttendanceRow(
                    attendanceUIModel:
                        AttendanceUIModel.fromAttendance(state.attendance)),
              ],
            ),
          if (state is GetPickedDateAttendanceLoading) const ReloadingWidget(),
        ]);
      },
    );
  }
}
