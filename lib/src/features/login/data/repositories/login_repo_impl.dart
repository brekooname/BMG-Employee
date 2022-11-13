import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:project_template/src/core/utils/app_strings.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/login_repo.dart';
import '../datasources/login_data_source.dart';
import '../models/user_model.dart';

class LoginRepoImpl implements LoginRepo {
  final LoginDataSourceImpl loginDataSourceImpl;

  LoginRepoImpl({required this.loginDataSourceImpl});
  @override
  Future<Either<Failure, User>> login(
      {required UserModel userModel,}) async {
    try {
      final response = await loginDataSourceImpl.login(
          userModel: userModel,);
      return response.fold(
        (failure) => left(failure),
        (userModel) => right(userModel),
      );
    } on ServerException {
      return left(ServerFailure());
    }
  }

  @override
  Future<bool> logout() async {
    return await loginDataSourceImpl.logout();
  }

  @override
  Future<Either<Failure, User>> tryRelogin() async {
    try {
      final res = await loginDataSourceImpl.tryRelogin();
      return res.fold((failure) => left(failure), (user) => right(user));
    } on ServerException {
      return left(ServerFailure());
    }
  }
  
  @override
  Future<Either<Failure, bool>> loginWithPhoneNumber({required String phoneNumber, required VoidCallback onSuccess})async {
    try{
     final isSent= await loginDataSourceImpl.loginWithPhoneNumber(phoneNumber: phoneNumber, onSuccess: onSuccess);
      if(isSent){
        return right(true);
      }else{
        return left(CacheFailure(message: AppStrings.phoneNumberNotExist));
      }
    }catch (exception){
        return left(ServerFailure(message: exception.toString()));
    }
  }
  
  @override
  Future<Either<Failure, bool>> verifySMSCode({required String phoneNumber,}) async{
   try{
     final isCorrect= await loginDataSourceImpl.verifySMSCode(phoneNumber: phoneNumber);
      if(isCorrect){
        return right(true);
      }else{
        return left(CacheFailure(message: AppStrings.smsCodeWrong));
      }
    }catch (exception){
        return left(ServerFailure(message: exception.toString()));
    }
  }

}
