import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:project_template/src/core/utils/app_controllers.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/shared/shared.dart';
import '../../../../core/utils/app_dialogs.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/company_icon.dart';
import '../../../../core/widgets/main_screen_padding.dart';
import '../../../../core/widgets/regular_button.dart';
import '../../../../core/widgets/reloading_widget.dart';
import '../../../../core/widgets/vertical_sized_box.dart';
import '../cubit/login_cubit.dart';

class CodeVerificationScreen extends StatefulWidget {
  const CodeVerificationScreen({super.key});

  @override
  State<CodeVerificationScreen> createState() => _CodeVerificationScreenState();
}

class _CodeVerificationScreenState extends State<CodeVerificationScreen> {
  late Timer timer;
  int _start = 30;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  bool _alreadyResent = false;

  bool get alreadyResent {
    return _alreadyResent;
  }

  bool _loading = false;

  bool get loading {
    return _loading;
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: MainScreenPadding(
        children: [
          const VerticalSizedBox(),
          const VerticalSizedBox(),
          const CompanyIcon(iconSizeFromHeight: .1),
          const VerticalSizedBox(),
          Text(
            "Verification Code",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          PinCodeTextField(
            appContext: context,
            length: 6,
            onChanged: (value) => smsCode = value,
            autoUnfocus: true,
            autoFocus: true,
            autoDismissKeyboard: true,
            enablePinAutofill: true,
            keyboardType: TextInputType.number,
            cursorColor: Colors.black,
          ),
          const VerticalSizedBox(),
          BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is VerifyCodeLoading) {
                setState(() {
                  _loading = true;
                });
              } else if (state is VerifyCodeFailure) {
                AppDialogs.appSnackBar(context: context, text: state.message);
                setState(() {
                  _loading = false;
                });
              } else if (state is VerifyCodeSuccess) {
                Navigator.of(context).pushReplacementNamed(Routes.homeRoute);
              }
            },
            builder: (context, state) {
              return loading
                  ? const ReloadingWidget()
                  : RegularButton(
                      text: AppStrings.confirm,
                      onPressed: () async {
                        if (smsCode.length == 6) {
                          await BlocProvider.of<LoginCubit>(context)
                              .verifySMSCode(
                                  phoneNumber:
                                      '+2${phoneNumberController.text.trim()}');
                        } else {
                          AppDialogs.appSnackBar(
                              context: context,
                              text: AppStrings.smsCodeRequired);
                        }
                      });
            },
          ),
          const VerticalSizedBox(),
          _start == 0
              ? TextButton(
                  onPressed: () async {
                    await BlocProvider.of<LoginCubit>(context)
                        .loginWithPhoneNumber(
                      phoneNumber: '+2${phoneNumberController.text.trim()}',
                      onSuccess: () => AppDialogs.appSnackBar(
                          context: context, text: AppStrings.smsCodeSent),
                    );
                    setState(() {
                      _start = 30;
                      startTimer();
                    });
                  },
                  child: const Text(AppStrings.sendCodeAgain))
              : Text(
                  _start.toString(),
                  style: Theme.of(context).textTheme.headline2,
                ),
        ],
      ),
    );
  }
}
