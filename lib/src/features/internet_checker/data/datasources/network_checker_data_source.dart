import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkCheckerDataSource{
  StreamSubscription<ConnectivityResult> networkCheck();
}

class NetworkCheckerDataSourceImpl implements NetworkCheckerDataSource{
  final Connectivity connectivity;

  NetworkCheckerDataSourceImpl({required this.connectivity});
  @override
   StreamSubscription<ConnectivityResult> networkCheck() {
    return connectivity.onConnectivityChanged.listen((event) {});
  }

}