import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constant/constant.dart';
import '../../../../core/shared/shared.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/app_strings.dart';
import '../../data/models/user_model.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/login_use_case_impl.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCaseImpl loginUseCaseImpl;
  LoginCubit({required this.loginUseCaseImpl}) : super(LoginInitial());

  Future login({required UserModel userModel,}) async {
    emit(LoginLoading());
    final response =
        await loginUseCaseImpl.login(userModel);
    emit(response.fold((failure) => LoginFailure(Constant.mapFailureToString(failure)),
        (user) {
      currentUser = user;
      return LoginSuccess(user);
    }));
  }

  Future logout() async {
    emit(LogoutLoading());
    final response = await loginUseCaseImpl.logout();
    if (response) {
      emit(LogoutSuccess());
    } else {
      emit(const LogoutFailure(AppStrings.logoutFailure));
    }
  }

  Future tryRelogin() async {
    emit(ReloginLoading());
    final res = await loginUseCaseImpl.tryRelogin();
    emit(res.fold((failure) => ReloginFailure(Constant.mapFailureToString(failure)),
        (user) => ReloginSuccess(user)));
  }


  Future loginWithPhoneNumber({required String phoneNumber,required VoidCallback onSuccess})async{
    emit(SendCodeLoading());
    final res=await loginUseCaseImpl.loginWithPhoneNumber(phoneNumber: phoneNumber, onSuccess: onSuccess);
    emit(res.fold((failure) => SendCodeFailure(Constant.mapFailureToString(failure)), (isSent) => SendCodeSuccess(),));
  }

  Future verifySMSCode({required String phoneNumber})async{
    emit(VerifyCodeLoading());
    final res=await loginUseCaseImpl.verifySMSCode(phoneNumber: phoneNumber);
    emit(res.fold((failure) => VerifyCodeFailure(Constant.mapFailureToString(failure)), (isCorrect) => VerifyCodeSuccess(),));
  }

}
