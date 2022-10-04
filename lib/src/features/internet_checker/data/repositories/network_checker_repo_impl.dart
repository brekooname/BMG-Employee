import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';

import 'package:project_template/src/core/error/failures.dart';

import 'package:dartz/dartz.dart';

import '../../domain/repositories/network_checker_repo.dart';
import '../datasources/network_checker_data_source.dart';

class NetworkCheckerRepoImpl implements NetworkCheckerRepo {
  final NetworkCheckerDataSource networkCheckerDataSource;

  NetworkCheckerRepoImpl({required this.networkCheckerDataSource});

  @override
  Stream<Either<Failure, StreamSubscription<ConnectivityResult>>>
      networkCheck() async* {
    try {
      yield right(networkCheckerDataSource.networkCheck());
    } on ServerFailure {
      yield Left(ServerFailure());
    }
  }
}
