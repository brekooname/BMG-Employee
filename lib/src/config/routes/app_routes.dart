import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/test/test_screen.dart';
import '../../core/utils/app_strings.dart';
import '../../features/internet_checker/presentation/bloc/network_checker_bloc.dart';
import '../../features/internet_checker/presentation/screens/no_internet_screen.dart';
import '../../features/login/presentation/cubit/login_cubit.dart';
import '../../features/login/presentation/screens/home_screen.dart';
import '../../features/login/presentation/screens/login_screen.dart';

import '../../features/splash/presentation/screens/splash_screen.dart';
import 'package:project_template/src/injector_container.dart' as di;

class Routes {
  static const String initialRoute = "/";
  static const String noInternetRoute = "/NoInternetRoute";
  static const String loginRoute = "/loginRoute";
  static const String homeRoute = "/homeRoute";
}

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          // const TestScreen(),
        );
      case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<LoginCubit>(
            create: (context) => di.getIt<LoginCubit>(),
            child: BlocConsumer<NetworkCheckerBloc, NetworkCheckerState>(
              listener: (context, state) {
                if (state is NetworkNotConnectedState) {
                  Navigator.pushNamed(context, Routes.noInternetRoute);
                } else {
                  Navigator.pushReplacementNamed(context, Routes.loginRoute);
                }
              },
              builder: (context, state) {
                if (state is NetworkNotConnectedState) {
                  return const NoInternetScreen();
                } else {
                  return const LoginScreen();
                }
              },
            ),
          ),
        );
      case Routes.noInternetRoute:
        return MaterialPageRoute(
          builder: (_) => const NoInternetScreen(),
        );
      case Routes.homeRoute:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: ((context) => const Scaffold(
            body: Center(
              child: Text(AppStrings.noRouteFound),
            ),
          )),
    );
  }
}
