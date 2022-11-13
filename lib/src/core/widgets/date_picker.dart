import 'package:flutter/material.dart';

class DatePicker {
  static Future<int?> pickDate({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    initialDate = DateTime.now();
    firstDate = DateTime.now();
    lastDate = DateTime.now().add(const Duration(days: 60));
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate);
    return (pickedDate == null) ? null : pickedDate.microsecondsSinceEpoch;
  }

  static Future<int?> pickTime({
    required BuildContext context,
    TimeOfDay? initialTime,
  }) async {
    initialTime = TimeOfDay.now();
    final pickedTime = await showTimePicker(
        context: context,
        initialTime: initialTime,
            );
    if (pickedTime == null) return null;
    final now = DateTime.now();
    final dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      pickedTime.hour,
      pickedTime.minute,
    );
    return dateTime.microsecondsSinceEpoch;
  }

  static DateTime readTimestamp(int microsecondsSinceEpoch) {
    return DateTime.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch);
  }
}
