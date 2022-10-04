import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/user.dart';

class UserModel extends User {

  const UserModel({
    String? userID,
    required String userCode,
     String? userName,
    String? userEmail,
    required String userPassword,
    String? userGender,
    String? userOffice,
  }) : super(
          userID: userID,
          userCode: userCode,
          userName: userName,
          userEmail: userEmail,
          userPassword: userPassword,
          userGender: userGender,
          userOffice: userOffice,
        );

  factory UserModel.fromJson(QueryDocumentSnapshot documentSnapshot) {
    return UserModel(
      userID: documentSnapshot.id,
      userCode: documentSnapshot.get("code"),
      userName: documentSnapshot.get("name"),
      userEmail: documentSnapshot.get("email"),
      userPassword: documentSnapshot.get("password"),
      userGender: documentSnapshot.get("gender"),
      userOffice: documentSnapshot.get("office"),
    );
  }
}
