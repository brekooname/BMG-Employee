import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/user_model.dart';
import '../entities/user.dart';

abstract class LoginRepo {
  Future<Either<Failure, User>> login({required UserModel userModel});
}
