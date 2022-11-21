// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceModel _$AttendanceModelFromJson(String id,Map<String, dynamic> json) =>
    AttendanceModel(
      id:id,
      date: json['date'] as String,
      userCode: json['userCode'] as String,
      time: json['time'] as String?,
      type: json['type'] as String?,
      startTime: json['startTime'],
      endTime: json['endTime'],
      isRamadan: json['isRamadan'] as bool? ?? false,
      isHoliday: json['isHoliday'] as bool? ?? false,
    );

Map<String, dynamic> _$AttendanceModelToJson(AttendanceModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'userCode': instance.userCode,
      'time': instance.time,
      'type': instance.type,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'isRamadan': instance.isRamadan,
      'isHoliday': instance.isHoliday,
    };
