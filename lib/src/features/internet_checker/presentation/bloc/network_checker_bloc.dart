import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/network_checker_use_case.dart';

part 'network_checker_event.dart';
part 'network_checker_state.dart';

class NetworkCheckerBloc
    extends Bloc<NetworkCheckerEvent, NetworkCheckerState> {
  StreamSubscription<ConnectivityResult>? subscription;
  final NetworkCheckerUseCaseImpl networkCheckerUseCaseImpl;
  NetworkCheckerBloc({required this.networkCheckerUseCaseImpl})
      : super(NetworkCheckerInitial()) {
    on<NetworkConnectedEvent>((event, emit) {
      emit(NetworkConnectedState());
    });
    on<NetworkNotConnectedEvent>((event, emit) {
      emit(NetworkNotConnectedState());
    });
    networkCheckerUseCaseImpl.call().listen((event) {
      event.fold(
        (failure) => add(NetworkNotConnectedEvent()),
        (stream) {
          subscription = stream;
          stream.onData((connectivityResult) {
            if (connectivityResult == ConnectivityResult.mobile ||
                connectivityResult == ConnectivityResult.wifi ||
                connectivityResult == ConnectivityResult.ethernet) {
              add(NetworkConnectedEvent());
            } else {
              add(NetworkNotConnectedEvent());
            }
          });
        },
      );
    });
  }
  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }
}
