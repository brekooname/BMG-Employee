import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/config/locale/app_localizations_setup.dart';
import 'src/config/routes/app_routes.dart';
import 'src/config/themes/app_theme.dart';
import 'src/core/utils/app_strings.dart';
import 'src/features/internet_checker/presentation/bloc/network_checker_bloc.dart';
import 'package:project_template/src/injector_container.dart' as di;

import 'src/features/login/presentation/cubit/login_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NetworkCheckerBloc>(
          create: (context) => di.getIt<NetworkCheckerBloc>(),
        ),
        BlocProvider<LoginCubit>(
          create: (context) => di.getIt<LoginCubit>(),
        ),
      ],
      child: MaterialApp(
        title: AppStrings.appName,
        locale: context.locale,
        localizationsDelegates: context.localizationDelegates,
        debugShowCheckedModeBanner: false,
        theme: appTheme(),
        onGenerateRoute: AppRoutes.onGenerateRoute,
        supportedLocales: AppLocalizationsSetup.supportedLocales,
      ),
    );
  }
}
