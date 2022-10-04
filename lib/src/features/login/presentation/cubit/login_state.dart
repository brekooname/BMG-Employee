part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LogingSuccess extends LoginState {
  final User user;

  const LogingSuccess(this.user);
  @override
  List<Object> get props => [user];
}

class LoginFailure extends LoginState {
  final String message;

  const LoginFailure(this.message);
  @override
  List<Object> get props => [message];
}

class LoginServerFailure extends LoginState {
  final String message;

  const LoginServerFailure(this.message);
  @override
  List<Object> get props => [message];
}
