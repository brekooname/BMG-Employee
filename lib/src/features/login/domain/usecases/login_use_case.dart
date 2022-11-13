import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/user_model.dart';
import '../entities/user.dart';

abstract class LoginUseCase {
  Future<Either<Failure, User>> login(UserModel userModel,);
  Future<Either<Failure, bool>> loginWithPhoneNumber(
      {required String phoneNumber, required VoidCallback onSuccess});
  Future<Either<Failure, bool>> verifySMSCode({required String phoneNumber,});
  Future<bool> logout();
    Future<Either<Failure, User>> tryRelogin();
}
