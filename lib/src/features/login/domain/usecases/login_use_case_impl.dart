import 'dart:ui';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/user_model.dart';
import '../entities/user.dart';
import '../repositories/login_repo.dart';
import 'login_use_case.dart';

class LoginUseCaseImpl implements LoginUseCase {
  final LoginRepo loginRepo;

  LoginUseCaseImpl({required this.loginRepo});

  @override
  Future<Either<Failure, User>> login(
    UserModel userModel,
  ) {
    return loginRepo.login(
      userModel: userModel,
    );
  }

  @override
  Future<bool> logout() {
    return loginRepo.logout();
  }

  @override
  Future<Either<Failure, User>> tryRelogin() {
    return loginRepo.tryRelogin();
  }

  @override
  Future<Either<Failure, bool>> loginWithPhoneNumber(
      {required String phoneNumber, required VoidCallback onSuccess}) {
    return loginRepo.loginWithPhoneNumber(
        phoneNumber: phoneNumber, onSuccess: onSuccess);
  }

  @override
  Future<Either<Failure, bool>> verifySMSCode({
    required String phoneNumber,
  }) {
    return loginRepo.verifySMSCode(phoneNumber: phoneNumber);
  }
}
