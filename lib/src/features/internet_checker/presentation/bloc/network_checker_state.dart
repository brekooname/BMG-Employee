
part of 'network_checker_bloc.dart';

abstract class NetworkCheckerState extends Equatable {
  const NetworkCheckerState();  

  @override
  List<Object> get props => [];
}
class NetworkCheckerInitial extends NetworkCheckerState {}

class NetworkConnectedState extends NetworkCheckerState {}

class NetworkNotConnectedState extends NetworkCheckerState {}
