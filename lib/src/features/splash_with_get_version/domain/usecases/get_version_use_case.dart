
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/useCases/usecase.dart';
import '../repositories/get_version_repo.dart';

class GetVersionUseCaseImpl implements UseCase<bool,NoParams>{
  final GetVersionRepo getVersionRepo;

  GetVersionUseCaseImpl({required this.getVersionRepo});
  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return getVersionRepo.shouldUpdate();
  }

  
}