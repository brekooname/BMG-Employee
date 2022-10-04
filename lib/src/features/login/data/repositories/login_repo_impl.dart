import 'package:dartz/dartz.dart';

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
  Future<Either<Failure, User>> login({required UserModel userModel}) async {
    try {
      final response = await loginDataSourceImpl.login(userModel: userModel);
      return response.fold(
        (failure) => left(ServerFailure(
          message: failure,
        )),
        (userModel) => right(userModel),
      );
    } on ServerException {
      return left(ServerFailure());
    }
  }
}
