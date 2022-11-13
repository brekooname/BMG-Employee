import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/app_strings.dart';
import '../../features/internet_checker/presentation/bloc/network_checker_bloc.dart';
import '../../features/internet_checker/presentation/screens/no_internet_screen.dart';
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
    return MaterialPageRoute(
      builder: (_) => BlocConsumer<NetworkCheckerBloc, NetworkCheckerState>(
        listener: (context, state) {
          if (state is NetworkConnectedState) {
            if (Navigator.canPop(context)) {
              Navigator.of(context).pop();
            }
          } else if (state is NetworkNotConnectedState) {
            Navigator.of(context).pushNamed(Routes.noInternetRoute);
          }
        },
        builder: (context, state) {
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
              return const HomeScreen();
            case Routes.noInternetRoute:
            return const NoInternetScreen();
            default:
              return undefinedRoute();
          }
        },
      ),
    );
    // switch (routeSettings.name) {
    //   case Routes.initialRoute:
    //     return MaterialPageRoute(
    //       builder: (_) => MultiBlocProvider(
    //         providers: [
    //           BlocProvider<GetVersionCubit>(
    //             create: (context) =>
    //                 di.getIt<GetVersionCubit>()..shouldUpdate(),
    //           ),
    //         ],
    //         child: const SplashScreen(),
    //       ),
    //       // const HomeScreen(),
    //     );
    //   case Routes.loginRoute:
    //     return MaterialPageRoute(
    //       builder: (_) => BlocProvider<LoginCubit>(
    //         create: (context) => di.getIt<LoginCubit>(),
    //         child: const LoginScreen(),
    //       ),
    //     );
    //   case Routes.noInternetRoute:
    //     return MaterialPageRoute(
    //       builder: (_) => const NoInternetScreen(),
    //     );
    //   case Routes.homeRoute:
    //     return MaterialPageRoute(
    //       builder: (_) => BlocProvider<AttendanceCubit>(
    //         create: (context) => di.getIt<AttendanceCubit>(),
    //         child: const HomeScreen(),
    //       ),
    //     );
    //   default:
    //     return undefinedRoute();
    // }
  }

  static Scaffold undefinedRoute() {
    return const Scaffold(
      body: Center(
        child: Text(AppStrings.noRouteFound),
      ),
    );
  }
}
