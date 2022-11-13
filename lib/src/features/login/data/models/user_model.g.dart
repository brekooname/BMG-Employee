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
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'userCode': instance.userCode,
      'userName': instance.userName,
      'userEmail': instance.userEmail,
      'userPassword': instance.userPassword,
      'userGender': instance.userGender,
      'userOffice': instance.userOffice,
    };
