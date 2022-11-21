import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String userCode;
  final String? userName;
  final String? userEmail;
  final String userPassword;
  final String? userGender;
  final String? userOffice;
  final String? userPhoneNumber;
  final int? userWorkingHours;
  final int? userRamadanWorkingHours;
  final int? userAnnualVacation;
  final int? userSicknessLeave;

  const User({
    required this.userCode,
    this.userName,
    this.userEmail,
    required this.userPassword,
    this.userGender,
    this.userOffice,
    this.userPhoneNumber,
    this.userWorkingHours,
    this.userRamadanWorkingHours,
    this.userAnnualVacation,
    this.userSicknessLeave,
  });

  @override
  List<Object?> get props => [
        userCode,
        userName,
        userEmail,
        userPassword,
        userGender,
        userOffice,
        userPhoneNumber,
        userWorkingHours,
        userRamadanWorkingHours,
        userAnnualVacation,
        userSicknessLeave,
      ];
}
