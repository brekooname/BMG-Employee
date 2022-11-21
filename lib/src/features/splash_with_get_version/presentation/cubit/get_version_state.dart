part of 'get_version_cubit.dart';

abstract class GetVersionState extends Equatable {
  const GetVersionState();

  @override
  List<Object> get props => [];
}

class SplashWithGetVersionInitial extends GetVersionState {}

class GetVersionLoading extends GetVersionState {}

class GetVersionFailed extends GetVersionState {
  final String message;

  const GetVersionFailed(this.message);
  @override
  List<Object> get props => [message];
}

class VersionIsUpToDate extends GetVersionState {}

class VersionIsFine extends GetVersionState {}
