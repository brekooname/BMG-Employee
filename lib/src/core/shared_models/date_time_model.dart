import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

class DateTimeModel {
  final int microsecondsSinceEpoch;
  late String month;
  late String date;
  late String time;
  late bool isRamadan;
  DateTimeModel({required this.microsecondsSinceEpoch}) {
    final dateTime =
        DateTime.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch);
    date = DateFormat().add_yMMMMEEEEd().format(dateTime);
    month = DateFormat().add_MMMM().format(dateTime);
    time = DateFormat().add_Hm().format(dateTime);
    isRamadan=HijriCalendar.fromDate(dateTime).hMonth ==9;
  }
}
