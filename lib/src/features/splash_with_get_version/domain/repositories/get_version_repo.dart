import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class GetVersionRepo{
  Future<Either<Failure,bool>> shouldUpdate();
}