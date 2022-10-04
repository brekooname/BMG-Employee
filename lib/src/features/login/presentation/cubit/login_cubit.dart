import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/app_strings.dart';
import '../../data/models/user_model.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/login_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCaseImpl loginUseCaseImpl;
  LoginCubit({required this.loginUseCaseImpl}) : super(LoginInitial());

  Future login({required UserModel userModel}) async {
    emit(LoginLoading());
    final response = await loginUseCaseImpl.call(userModel);
    emit(response.fold((failure) => LoginFailure(_mapFailureToString(failure)),
        (user) => LogingSuccess(user)));
  }

  String _mapFailureToString(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return failure.props.first.toString();
      case CacheFailure:
        return AppStrings.cacheFailure;
      default:
        return AppStrings.unexpectedFailure;
    }
  }
}
