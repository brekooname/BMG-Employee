import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_template/src/core/shared_models/date_time_model.dart';

import '../../core/utils/app_strings.dart';
import '../../features/attendance/presentation/cubit/attendance_cubit.dart';
import '../../features/login/presentation/cubit/login_cubit.dart';
import '../../features/attendance/presentation/screens/home_screen.dart';
import '../../features/login/presentation/screens/code_verification_screen.dart';
import '../../features/login/presentation/screens/login_screen.dart';

import '../../features/splash_with_get_version/presentation/cubit/get_version_cubit.dart';
import '../../features/splash_with_get_version/presentation/screens/splash_screen.dart';
import 'package:project_template/src/injector_container.dart' as di;

class Routes {
  static const String initialRoute = "/";
  static const String noInternetRoute = "/NoInternetRoute";
  static const String loginRoute = "/loginRoute";
  static const String codeVerificationRoute = "/codeVerificationRoute";
  static const String homeRoute = "/homeRoute";
}

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    return MaterialPageRoute(builder: (_) {
      switch (routeSettings.name) {
        case Routes.initialRoute:
          return MultiBlocProvider(
            providers: [
              BlocProvider<GetVersionCubit>(
                create: (context) =>
                    di.getIt<GetVersionCubit>()..shouldUpdate(),
              ),
              BlocProvider<LoginCubit>(
                create: (context) => di.getIt<LoginCubit>(),
              ),
            ],
            child: const SplashScreen(),
          );
        case Routes.loginRoute:
          return const LoginScreen();
        case Routes.codeVerificationRoute:
          return const CodeVerificationScreen();
        case Routes.homeRoute:
          return BlocProvider(
            create: (context) => di.getIt<AttendanceCubit>()
              ..init(
                  day: DateTimeModel(
                          microsecondsSinceEpoch:
                              DateTime.now().microsecondsSinceEpoch)
                      .date),
            child: const HomeScreen(),
          );
        // case Routes.noInternetRoute:
        //   return const NoInternetScreen();
        default:
          return undefinedRoute();
      }
    }
        // BlocConsumer<NetworkCheckerBloc, NetworkCheckerState>(
        //   listener: (context, state) {
        //     if (state is NetworkConnectedState) {
        //       if (Navigator.canPop(context)) {
        //         Navigator.of(context).pop();
        //       }
        //     } else if (state is NetworkNotConnectedState) {
        //       Navigator.of(context).pushNamed(Routes.noInternetRoute);
        //     }
        //   },
        //   builder: (context, state) {

        // },
        // ),
        );
  }

  static Scaffold undefinedRoute() {
    return const Scaffold(
      body: Center(
        child: Text(AppStrings.noRouteFound),
      ),
    );
  }
}
