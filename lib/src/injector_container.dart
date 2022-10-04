
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/api/dio_consumer.dart';
import 'core/api/dio_interceptors.dart';
import 'core/firebase/firebase_firestore_repository.dart';
import 'features/internet_checker/netword_checker_injection.dart';
import 'features/login/login_injection.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  //!features
  // initQuoteInjection();
  initNetworkCheckerInjection();
  initLoginInjection();

  //!Core
  getIt.registerLazySingleton<DioConsumer>(() => DioConsumer(client: getIt()));
  getIt.registerLazySingleton<FirebaseRepository>(() => FirebaseRepository());
  //!External
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(() => AppIntercepters());
  getIt.registerLazySingleton(() => LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true));
  getIt.registerLazySingleton(() => Connectivity());
}
