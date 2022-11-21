import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_template/src/core/utils/media_query_values.dart';
import '../../../../../core/constant/constant.dart';
import '../../../../../core/decoration/box_decoration.dart';
import '../../../../../core/shared/shared.dart';
import '../../../../../core/shared_models/date_time_model.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/widgets/date_picker.dart';
import '../../../../../core/widgets/regular_button.dart';
import '../../../../../core/widgets/reloading_widget.dart';
import '../../../../../core/widgets/vertical_sized_box.dart';
import '../../cubit/attendance_cubit.dart';
import '../../ui_models/attendance_ui_model.dart';
import '../../widgets/attendance_row.dart';
import '../../widgets/attendance_table_header.dart';
import '../../widgets/vacations_box.dart';

class AttendanceProposalScreen extends StatefulWidget {
  const AttendanceProposalScreen({
    super.key,
  });

  @override
  State<AttendanceProposalScreen> createState() =>
      _AttendanceProposalScreenState();
}

class _AttendanceProposalScreenState extends State<AttendanceProposalScreen> {
  int _date = DateTime.now().microsecondsSinceEpoch;
  int _time = DateTime.now().microsecondsSinceEpoch;

  bool _isHoliday = false;

  String get date {
    return DateTimeModel(microsecondsSinceEpoch: _date).date;
  }

  String get time {
    return DateTimeModel(microsecondsSinceEpoch: _time).time;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final attendanceCubit = BlocProvider.of<AttendanceCubit>(context);
    return BlocBuilder<AttendanceCubit, AttendanceState>(
      buildWhen: (previous, current) {
        return current is GetPickedDateAttendanceProposalFailure ||
            current is GetPickedDateAttendanceProposalLoading ||
            current is GetPickedDateAttendanceProposalSuccess;
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
                    onPressed: () async {
                      final pickedDate = await DatePicker.pickDate(
                        context: context,
                        initialDate: DateTime.fromMicrosecondsSinceEpoch(_date),
                      );
                      if (pickedDate != null) {
                        setState(() => _date = pickedDate);
                        await attendanceCubit.getPickedDateProposalAttendance(
                            day: DateTimeModel(microsecondsSinceEpoch: _date)
                                .date);
                      }
                    },
                    child: Text(date,
                        style: textTheme.headline2!
                            .copyWith(color: Theme.of(context).primaryColor))),
                TextButton(
                    onPressed: () async {
                      final time = DateTime.fromMicrosecondsSinceEpoch(_time);
                      final pickedTime = await DatePicker.pickTime(
                          context: context,
                          initialTime:
                              TimeOfDay(hour: time.hour, minute: time.minute));
                      if (pickedTime != null) {
                        setState(() => _time = pickedTime);
                      }
                    },
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
                  value: _isHoliday,
                  onChanged: (newval) async {
                    setState(() {
                      _isHoliday = !_isHoliday;
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
          if (state is GetPickedDateAttendanceProposalSuccess)
            RegularButton(
                text: getRightAction(
                    AttendanceUIModel.fromAttendance(state.attendance)),
                onPressed: state.attendance.time != null
                    ? null
                    : () {
                        DateTimeModel dateModel =
                            DateTimeModel(microsecondsSinceEpoch: _date);
                        DateTimeModel timeModel =
                            DateTimeModel(microsecondsSinceEpoch: _time);
                        debugPrint(dateModel.date);
                        debugPrint(dateModel.month);
                        debugPrint(timeModel.time);
                      }),
          if (state is GetPickedDateAttendanceProposalFailure)
            RegularButton(
                text: AttendanceAction.start.name,
                onPressed: () {
                  ///ToDo start function
                }),
          if (state is GetPickedDateAttendanceProposalLoading)
            const ReloadingWidget(),
          const VerticalSizedBox(),
          if (state is GetPickedDateAttendanceProposalFailure)
            Text(
              AppStrings.noAttendanceAvailable,
              style: textTheme.headline2!.copyWith(color: AppColors.hint),
            ),
          if (state is GetPickedDateAttendanceProposalSuccess)
            Column(
              children: [
                const AttendanceHeaderRow(),
                AttendanceRow(
                    attendanceUIModel:
                        AttendanceUIModel.fromAttendance(state.attendance)),
              ],
            ),
          if (state is GetPickedDateAttendanceProposalLoading)
            const ReloadingWidget(),
        ]);
      },
    );
  }
}
