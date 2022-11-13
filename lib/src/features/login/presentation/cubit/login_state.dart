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

///
class LogoutLoading extends LoginState {}

class LogoutSuccess extends LoginState {}

class LogoutFailure extends LoginState {
  final String message;

  const LogoutFailure(this.message);
  @override
  List<Object> get props => [message];
}

///
class ReloginLoading extends LoginState {}

class ReloginSuccess extends LoginState {
  final User user;

  const ReloginSuccess(this.user);
  @override
  List<Object> get props => [user];
}

class ReloginFailure extends LoginState {
  final String message;

  const ReloginFailure(this.message);
  @override
  List<Object> get props => [message];
}

///
class SendCodeLoading extends LoginState {}

class SendCodeSuccess extends LoginState {}

class SendCodeFailure extends LoginState {
  final String message;

  const SendCodeFailure(this.message);
  @override
  List<Object> get props => [message];
}

///
class VerifyCodeLoading extends LoginState {}

class VerifyCodeSuccess extends LoginState {}

class VerifyCodeFailure extends LoginState {
  final String message;

  const VerifyCodeFailure(this.message);
  @override
  List<Object> get props => [message];
}
