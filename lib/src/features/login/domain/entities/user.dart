import 'package:equatable/equatable.dart';

class User extends Equatable{
  final String? userID;
  final String userCode;
  final String? userName;
  final String? userEmail;
  final String userPassword;
  final String? userGender;
  final String? userOffice;

  const User(
      { this.userID,
      required this.userCode,
       this.userName,
      this.userEmail,
      required this.userPassword,
      this.userGender,
      this.userOffice,});
      
        @override
        List<Object?> get props => [userID,userCode,userName,userEmail,userPassword,userGender,userOffice,];
}
