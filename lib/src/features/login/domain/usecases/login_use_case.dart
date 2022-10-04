

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/useCases/usecase.dart';
import '../../data/models/user_model.dart';
import '../entities/user.dart';
import '../repositories/login_repo.dart';

class LoginUseCaseImpl implements UseCase<User,UserModel>{
  final LoginRepo loginRepo;

  LoginUseCaseImpl({required this.loginRepo});
  @override
  Future<Either<Failure, User>> call(UserModel userModel) {
   return loginRepo.login(userModel: userModel);
  }
  
}