import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/constant/constant.dart';
import '../../../../core/decoration/box_decoration.dart';
import '../../../../core/utils/app_controllers.dart';
import '../../../../core/utils/app_dialogs.dart';
import '../../../../core/utils/media_query_values.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/company_icon.dart';
import '../../../../core/widgets/main_screen_padding.dart';
import '../../../../core/widgets/regular_button.dart';
import '../../../../core/widgets/reloading_widget.dart';
import '../../../../core/widgets/text_form_widget.dart';
import '../../../../core/widgets/vertical_sized_box.dart';
import '../../data/models/user_model.dart';
import '../cubit/login_cubit.dart';
import '../widgets/stay_login_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _obscure = true;
  bool get obscure {
    return _obscure;
  }

  bool _loading = false;
  bool get loading {
    return _loading;
  }

  bool _isLoginWithPhoneNumber = false;
  bool get isLoginWithPhoneNumber {
    return _isLoginWithPhoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainScreenPadding(
        children: [
          const CompanyIcon(),
          Container(
            padding: EdgeInsets.all(context.containerPadding),
            decoration: boxDecoration,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const VerticalSizedBox(),
                  isLoginWithPhoneNumber
                      ? TextFormWidget(
                          labelText: AppStrings.phoneNumber,
                          textEditingController: phoneNumberController,
                          textInputType: TextInputType.phone,
                          validatorFunc: (String? value) {
                            if (value == null) {
                              return AppStrings.phoneNumberRequired;
                            } else if (value.isEmpty) {
                              return AppStrings.phoneNumberRequired;
                            } else if (value.length != 11 ||
                                !value.startsWith("01")) {
                              return AppStrings.phoneNumberNotValid;
                            }
                            return null;
                          },
                        )
                      : Column(
                          children: [
                            TextFormWidget(
                              labelText: AppStrings.code,
                              textEditingController: codeController,
                              validatorFunc: (String? value) {
                                if (value == null) {
                                  return AppStrings.codeRequired;
                                } else if (value.isEmpty || value.length != 4) {
                                  return AppStrings.codeRequired;
                                }
                                return null;
                              },
                            ),
                            const VerticalSizedBox(),
                            TextFormWidget(
                              labelText: AppStrings.password,
                              textEditingController: passwordController,
                              obscure: obscure,
                              suffix: IconButton(
                                icon: Icon(obscure
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () => setState(() {
                                  _obscure = !_obscure;
                                }),
                              ),
                              validatorFunc: (String? value) {
                                if (value == null) {
                                  return AppStrings.passwordRequired;
                                } else if (value.isEmpty) {
                                  return AppStrings.passwordRequired;
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                  const VerticalSizedBox(),
                  const StayLoginWidget(),
                  const VerticalSizedBox(),
                  BlocConsumer<LoginCubit, LoginState>(
                    listener: (context, state) {
                      if (state is LoginLoading || state is SendCodeLoading) {
                        setState(() {
                          _loading = true;
                        });
                      } else if (state is LoginFailure) {
                        AppDialogs.appSnackBar(
                            context: context, text: state.message);
                        setState(() {
                          _loading = false;
                        });
                      } else if (state is SendCodeFailure) {
                        AppDialogs.appSnackBar(
                            context: context, text: state.message);
                        setState(() {
                          _loading = false;
                        });
                      } else if (state is LogingSuccess) {
                        codeController.clear();
                        passwordController.clear();
                        Navigator.of(context)
                            .pushReplacementNamed(Routes.homeRoute);
                      }
                    },
                    builder: (context, state) {
                      return loading
                          ? const ReloadingWidget()
                          : RegularButton(
                              text: AppStrings.login,
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  if (isLoginWithPhoneNumber) {
                                    await BlocProvider.of<LoginCubit>(context)
                                        .loginWithPhoneNumber(
                                            phoneNumber:
                                                '+2${phoneNumberController.text.trim()}',
                                            onSuccess: () =>
                                                Navigator.of(context)
                                                    .pushReplacementNamed(
                                                  Routes.codeVerificationRoute,
                                                ));
                                  } else {
                                    await BlocProvider.of<LoginCubit>(context)
                                        .login(
                                      userModel: UserModel(
                                        userCode: codeController.text.trim(),
                                        userPassword:
                                            passwordController.text.trim(),
                                      ),
                                    );
                                  }
                                }
                              },
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
          const VerticalSizedBox(),
          if (!Constant.isWindows())
            TextButton(
                onPressed: () => setState(
                    () => _isLoginWithPhoneNumber = !_isLoginWithPhoneNumber),
                child: Text(!isLoginWithPhoneNumber
                    ? AppStrings.loginWithPhoneNumber
                    : AppStrings.loginWithCode)),
        ],
      ),
    );
  }
}
