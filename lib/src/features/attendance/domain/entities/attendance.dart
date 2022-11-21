class Attendance {
  final String id;
  final String date;
  final String userCode;
   String? time;
   String? type;
   DateTime? startTime;
   DateTime? endTime;
   bool? isRamadan;
   bool? isHoliday;
  Attendance(
      {
        required this.id,
        required this.date,
        required this.userCode,
        this.time,
      this.type,
      this.startTime,
      this.endTime,
       this.isRamadan=false,
       this.isHoliday=false});
}
