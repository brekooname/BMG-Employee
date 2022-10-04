part of 'network_checker_bloc.dart';

abstract class NetworkCheckerEvent extends Equatable {
  const NetworkCheckerEvent();

  @override
  List<Object> get props => [];
}

class NetworkConnectedEvent extends NetworkCheckerEvent {}

class NetworkNotConnectedEvent extends NetworkCheckerEvent {}
