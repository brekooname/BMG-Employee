// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      userCode: json['userCode'] as String,
      userName: json['userName'] as String?,
      userEmail: json['userEmail'] as String?,
      userPassword: json['userPassword'] as String,
      userGender: json['userGender'] as String?,
      userOffice: json['userOffice'] as String?,
      userPhoneNumber: json['userPhoneNumber'] as String?,
      userWorkingHours: json['userWorkingHours'] as int?,
      userRamadanWorkingHours: json['userRamadanWorkingHours'] as int?,
      userAnnualVacation: json['userAnnualVacation'] as int?,
      userSicknessLeave: json['userSicknessLeave'] as int?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'userCode': instance.userCode,
      'userName': instance.userName,
      'userEmail': instance.userEmail,
      'userPassword': instance.userPassword,
      'userGender': instance.userGender,
      'userOffice': instance.userOffice,
      'userPhoneNumber': instance.userPhoneNumber,
      'userWorkingHours': instance.userWorkingHours,
      'userRamadanWorkingHours': instance.userRamadanWorkingHours,
      'userAnnualVacation': instance.userAnnualVacation,
      'userSicknessLeave': instance.userSicknessLeave,
    };
