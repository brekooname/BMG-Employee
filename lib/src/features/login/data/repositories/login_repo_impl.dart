import 'dart:ui';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/app_strings.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/login_repo.dart';
import '../datasources/login_data_source.dart';
import '../models/user_model.dart';

class LoginRepoImpl implements LoginRepo {
  final LoginDataSourceImpl loginDataSourceImpl;
  final NetworkInfo networkInfo;

  LoginRepoImpl({
    required this.loginDataSourceImpl,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, User>> login({
    required UserModel userModel,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await loginDataSourceImpl.login(
          userModel: userModel,
        );
        return response.fold(
          (failure) => left(failure),
          (userModel) => right(userModel),
        );
      } catch (exception) {
        return left(ServerFailure(message: exception.toString()));
      }
    }
    return left(ServerFailure(message: AppStrings.serverFailure));
  }

  @override
  Future<bool> logout() async {
    if (await networkInfo.isConnected) {
      try {
        return await loginDataSourceImpl.logout();
      } on ServerException {
        return false;
      }
    }
    return false;
  }

  @override
  Future<Either<Failure, User>> tryRelogin() async {
    if (await networkInfo.isConnected) {
      try {
        final res = await loginDataSourceImpl.tryRelogin();
        return res.fold((failure) => left(failure), (user) => right(user));
      } catch (exception) {
        return left(ServerFailure(message: exception.toString()));
      }
    }
    return left(ServerFailure(message: AppStrings.serverFailure));
  }

  @override
  Future<Either<Failure, bool>> loginWithPhoneNumber(
      {required String phoneNumber, required VoidCallback onSuccess}) async {
    if (await networkInfo.isConnected) {
      try {
        final isSent = await loginDataSourceImpl.loginWithPhoneNumber(
            phoneNumber: phoneNumber, onSuccess: onSuccess);
        if (isSent) {
          return right(true);
        } else {
          return left(CacheFailure(message: AppStrings.phoneNumberNotExist));
        }
      } catch (exception) {
        return left(ServerFailure(message: exception.toString()));
      }
    }
    return left(ServerFailure(message: AppStrings.serverFailure));
  }

  @override
  Future<Either<Failure, bool>> verifySMSCode({
    required String phoneNumber,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final isCorrect =
            await loginDataSourceImpl.verifySMSCode(phoneNumber: phoneNumber);
        if (isCorrect) {
          return right(true);
        } else {
          return left(CacheFailure(message: AppStrings.smsCodeWrong));
        }
      } catch (exception) {
        return left(ServerFailure(message: exception.toString()));
      }
    }
    return left(ServerFailure(message: AppStrings.serverFailure));
  }
}
