import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../ui_models/attendance_ui_model.dart';
import 'table_cell_widget.dart';

class AttendanceRow extends StatelessWidget {
  final AttendanceUIModel attendanceUIModel;
  const AttendanceRow({super.key, required this.attendanceUIModel});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.max, children: [
      TableCellWidget(
        flex: 6,
        content: left(attendanceUIModel.date),
      ),
      if (attendanceUIModel.type != null)
        TableCellWidget(
          flex: 4,
          content: left(attendanceUIModel.type!),
        ),
      if (attendanceUIModel.type == null)
        TableCellWidget(
          flex: 2,
          content: left(attendanceUIModel.startTime ?? ""),
        ),
      if (attendanceUIModel.type == null)
        TableCellWidget(
          flex: 2,
          content: left(attendanceUIModel.endTime ?? ""),
        ),
      TableCellWidget(
        flex: 2,
        content: left(attendanceUIModel.time ?? ""),
      ),
      TableCellWidget(
        flex: 3,
        content: attendanceUIModel.isHoliday ?? false
            ? right(Icons.check)
            : left(""),
      ),
      TableCellWidget(
        flex: 3,
        content: attendanceUIModel.isRamadan ?? false
            ? right(Icons.check)
            : left(""),
      ),
    ]);
  }
}
