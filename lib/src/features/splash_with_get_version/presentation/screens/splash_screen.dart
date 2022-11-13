import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_template/src/core/constant/constant.dart';
import 'package:project_template/src/core/utils/media_query_values.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/shared/shared.dart';
import '../../../../core/utils/app_dialogs.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../login/domain/entities/user.dart';
import '../../../login/presentation/cubit/login_cubit.dart';
import '../cubit/get_version_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // late Timer _timer;

  // _startDelay() {
  //   _timer = Timer(
  //       const Duration(
  //         milliseconds: 700,
  //       ),
  //       () => _nextTo());
  // }

  _nextTo() async {
    await BlocProvider.of<LoginCubit>(context).tryRelogin();
  }

  _relogin(
    User user,
  ) {
    currentUser = user;
    Navigator.of(context).pushReplacementNamed(Routes.homeRoute);
  }

  _navigateToLogin() {
    Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
  }

  _upToDate() async =>
      await AppDialogs.showUnDismissibleDialog(context: context);

  @override
  void initState() {
    super.initState();
    // _startDelay();
  }

  @override
  void dispose() {
    //  _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: MultiBlocListener(
        listeners: [
          BlocListener<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is ReloginFailure) {
                if (state.message != "null") {
                  AppDialogs.appSnackBar(context: context, text: state.message);
                }

                _navigateToLogin();
              } else if (state is ReloginSuccess) {
                _relogin(state.user);
              }
            },
          ),
          BlocListener<GetVersionCubit, GetVersionState>(
            listener: (context, state) {
              if (state is VersionIsFine) {
                _nextTo();
              } else if (state is VersionIsUpToDate) {
                _upToDate();
              }
            },
          ),
        ],
        child: BlocBuilder<GetVersionCubit, GetVersionState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: context.width * .2),
                      child: Image.asset(
                        ImgAssets.bmgIcon,
                      )),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
