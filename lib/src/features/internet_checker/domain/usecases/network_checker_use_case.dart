import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/network_checker_repo.dart';

abstract class NetworkCheckerUseCase{

  Stream<Either<Failure,StreamSubscription<ConnectivityResult>>> call();
}

class NetworkCheckerUseCaseImpl implements NetworkCheckerUseCase{
  final NetworkCheckerRepo networkCheckerRepo;

  NetworkCheckerUseCaseImpl({required this.networkCheckerRepo});
  @override
  Stream<Either<Failure,StreamSubscription<ConnectivityResult>>> call() {
    return networkCheckerRepo.networkCheck();
  }

}