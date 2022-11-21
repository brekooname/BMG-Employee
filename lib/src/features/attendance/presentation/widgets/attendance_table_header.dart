import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/app_strings.dart';
import 'table_cell_widget.dart';

class AttendanceHeaderRow extends StatelessWidget {
  const AttendanceHeaderRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize:MainAxisSize.max,
      children: [
      TableCellWidget(
        flex: 6,
        content: left(AppStrings.date),
      ),
      TableCellWidget(
        flex: 2,
        content: left(AppStrings.start),
      ),
      TableCellWidget(
        flex: 2,
        content: left(AppStrings.end),
      ),
      TableCellWidget(
        flex: 2,
        content: left(AppStrings.time),
      ),
      TableCellWidget(
        flex: 3,
        content: left(AppStrings.holiday),
      ),
      TableCellWidget(
        flex: 3,
        content: left(AppStrings.ramadan),
      ),
    ]);
  }
}
