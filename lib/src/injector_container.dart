
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/api/dio_consumer.dart';
import 'core/api/dio_interceptors.dart';
import 'core/firebase/firebase_firestore_repository.dart';
import 'core/network/network_info.dart';
import 'features/attendance/attendance_injection.dart';
import 'features/login/login_injection.dart';
import 'features/splash_with_get_version/get_version_injection.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  //!features
  // initNetworkCheckerInjection();
  initGetVersionInjection();
  initLoginInjection();
  initAttendanceInjection();

  //!Core
  getIt.registerLazySingleton<DioConsumer>(() => DioConsumer(client: getIt()));
  getIt.registerLazySingleton<FirebaseRepository>(() => FirebaseRepository());
  getIt.registerLazySingleton<NetworkInfo>(()=>NetworkInfoImpl(internetConnectionChecker: getIt()));
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
  getIt.registerLazySingleton<InternetConnectionChecker>(() => InternetConnectionChecker());
  // getIt.registerLazySingleton(() => Connectivity());
}
