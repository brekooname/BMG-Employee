import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/firebase/firebase_firestore_repository.dart';
import '../../../../core/utils/app_strings.dart';
import '../models/user_model.dart';

abstract class LoginDataSource {
  Future<Either<String, UserModel>> login({required UserModel userModel});
}

class LoginDataSourceImpl implements LoginDataSource {
  final FirebaseRepository firebaseRepository;

  LoginDataSourceImpl({required this.firebaseRepository});
  @override
  Future<Either<String, UserModel>> login(
      {required UserModel userModel}) async {
    final List<QueryDocumentSnapshot<Map<String, dynamic>>>? docs =
        await firebaseRepository.fetch(data: "users", orderBy: "code");
    if (docs != null) {
      ///check if userData is correct
      for (QueryDocumentSnapshot<Map<String, dynamic>> element in docs) {
        UserModel user = UserModel.fromJson(element);
        if (user.userCode == userModel.userCode) {
          if (user.userPassword == userModel.userPassword) {
            return right(user);
          }
          return left(AppStrings.passwordIsWrong);
        }
      }
      return left(AppStrings.employeeCodeIsWrong);
    }
    return left(AppStrings.serverFailure);
  }
}
