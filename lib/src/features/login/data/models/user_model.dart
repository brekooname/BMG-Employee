import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/user.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends User {
  const UserModel({
    required String userCode,
    String? userName,
    String? userEmail,
    required String userPassword,
    String? userGender,
    String? userOffice,
  }) : super(
          userCode: userCode,
          userName: userName,
          userEmail: userEmail,
          userPassword: userPassword,
          userGender: userGender,
          userOffice: userOffice,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String,dynamic> toJson()=>_$UserModelToJson(this);

}
