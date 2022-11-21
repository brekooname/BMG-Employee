import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/shared_preferences_repo.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/firebase/firebase_firestore_repository.dart';
import '../../../../core/shared/shared.dart';
import '../../../../core/utils/app_strings.dart';
import '../models/user_model.dart';

abstract class LoginDataSource {
  Future<Either<Failure, UserModel>> login(
      {required UserModel userModel});
  Future<bool> loginWithPhoneNumber({required String phoneNumber,required VoidCallback onSuccess});
  Future<bool> verifySMSCode({required phoneNumber});
  Future<bool> logout();
  Future<Either<Failure, UserModel>> tryRelogin();
}

class LoginDataSourceImpl implements LoginDataSource {
  final FirebaseRepository firebaseRepository;

  LoginDataSourceImpl({
    required this.firebaseRepository,
  });
  @override
  Future<Either<Failure, UserModel>> login(
      {required UserModel userModel}) async {
    final document = await firebaseRepository.getDocument(
        documentPath: '${AppStrings.colUsers}/${userModel.userCode}');

    if (document != null) {
      ///check if userData is correct
      UserModel user = UserModel.fromJson(document.map);
      if (user.userCode == userModel.userCode) {
        if (user.userPassword == userModel.userPassword) {
          if (shouldStayLogin) {
            SharedPreferencesRepo.setString(
                AppStrings.savedUser, jsonEncode(user.toJson()));
          }
          return right(user);
        }
        return left(CacheFailure(message: AppStrings.passwordIsWrong));
      }
    }
    return left(CacheFailure(message: AppStrings.employeeCodeIsWrong));
  }

  @override
  Future<bool> logout() async {
    return SharedPreferencesRepo.reset();
  }

  @override
  Future<Either<Failure, UserModel>> tryRelogin() async {
    final isExist = await SharedPreferencesRepo.isExist(AppStrings.savedUser);
    if (isExist) {
      final res = await SharedPreferencesRepo.getString(AppStrings.savedUser);
      final json = jsonDecode(res!);
      final userModel = UserModel.fromJson(json);
      final doc = await firebaseRepository.getDocument(
          documentPath: '${AppStrings.colUsers}/${userModel.userCode}');
      if (doc != null) {
        ///check if userData is correct
        UserModel user = UserModel.fromJson(doc.map);
        if (user.userPassword == userModel.userPassword) {
          return right(user);
        }

        await SharedPreferencesRepo.remove(AppStrings.savedUser);
        return left(CacheFailure(message: AppStrings.passwordChanged));
      }

      await SharedPreferencesRepo.remove(AppStrings.savedUser);
      return left(CacheFailure(message: AppStrings.employeeNoLongerExist));
    }
    return left(ServerFailure());
  }

  @override
  Future<bool> loginWithPhoneNumber({required String phoneNumber,required VoidCallback onSuccess}) async {
    final List docs = await firebaseRepository.getDocumentsWhere(
        collection: AppStrings.colUsers,
        fieldPath: AppStrings.fieldPhoneNumber,
        isEqualTo: phoneNumber);
    if (docs.isNotEmpty) {
      await firebaseRepository.sendCodeWithPhoneNumber(phoneNumber: phoneNumber, onSuccess: onSuccess);
      return true;
    }
    return false;
  }

  @override
  Future<bool> verifySMSCode({required phoneNumber}) async{
    final isCorrect=await firebaseRepository.verifySMSCode();
    if(isCorrect){
      final List docs = await firebaseRepository.getDocumentsWhere(
        collection: AppStrings.colUsers,
        fieldPath: AppStrings.fieldPhoneNumber,
        isEqualTo: phoneNumber);
        final user=UserModel.fromJson(docs.first);
        currentUser=user;
      if(shouldStayLogin){
        SharedPreferencesRepo.setString(
                AppStrings.savedUser, jsonEncode(user.toJson()));
      }
      return true;
    }else{
        currentUser=null;
        return false;
    }
  }
}
