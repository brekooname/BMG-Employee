import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_template/src/features/login/presentation/screens/home_screen.dart';


import '../../../../config/routes/app_routes.dart';
import '../../../../core/constant/constant.dart';
import '../../../../core/utils/app_controllers.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/media_query_values.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/regular_button.dart';
import '../../../../core/widgets/reloading_widget.dart';
import '../../../../core/widgets/text_form_widget.dart';
import '../../../../core/widgets/vertical_sized_box.dart';
import '../../data/models/user_model.dart';
import '../cubit/login_cubit.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(context.paddingAll),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: context.height * .15,
                    child: Image.asset(
                      ImgAssets.bmgIcon,
                    )),
                VerticalSizedBox(
                  height: context.height * .04,
                ),
                Container(
                  padding: EdgeInsets.all(context.containerPadding),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: AppColors.hint,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      topRight: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.hint.withOpacity(.1),
                        spreadRadius: .5,
                        blurRadius: 2,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const VerticalSizedBox(),
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
                          validatorFunc: (String? value) {
                            if (value == null) {
                              return AppStrings.passwordRequired;
                            } else if (value.isEmpty) {
                              return AppStrings.passwordRequired;
                            }
                            return null;
                          },
                        ),
                        const VerticalSizedBox(),
                        BlocConsumer<LoginCubit, LoginState>(
                          listener: (context, state) {
                            if(state is LoginFailure){
                              Constant.appSnackBar(context: context, text: state.message);
                            }else if(state is LoginServerFailure){
                              Constant.appSnackBar(context: context, text: state.message);
                            }else if(state is LogingSuccess){
                              Navigator.of(context).pushReplacementNamed(Routes.homeRoute);
                            }
                          },
                          builder: (context, state) {
                            if(state is LoginLoading){
                              const ReloadingWidget();
                            }
                            return RegularButton(
                              text: AppStrings.login,
                              onPressed: () async{
                                if (formKey.currentState!.validate()) {
                                 await BlocProvider.of<LoginCubit>(context).login(userModel: UserModel(
                                    userCode: codeController.text.trim(),
                                    userPassword: passwordController.text.trim(),
                                  ));
                                }
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
