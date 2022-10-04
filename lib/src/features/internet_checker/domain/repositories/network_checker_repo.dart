


import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class NetworkCheckerRepo{
  Stream<Either<Failure,StreamSubscription<ConnectivityResult>>> networkCheck();
}