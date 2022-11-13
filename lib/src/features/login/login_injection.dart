
import '../../injector_container.dart';
import 'data/datasources/login_data_source.dart';
import 'data/repositories/login_repo_impl.dart';
import 'domain/repositories/login_repo.dart';
import 'domain/usecases/login_use_case_impl.dart';
import 'presentation/cubit/login_cubit.dart';


void initLoginInjection()  {
  ///Blocs
  getIt.registerFactory<LoginCubit>(() => LoginCubit(loginUseCaseImpl: getIt()));

  ///usecases
  getIt.registerLazySingleton<LoginUseCaseImpl>(() => LoginUseCaseImpl(loginRepo: getIt()));

  ///Repositories
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepoImpl(
        loginDataSourceImpl: getIt(),
      ));

  ///DataSources
  getIt.registerLazySingleton<LoginDataSourceImpl>(() => LoginDataSourceImpl(firebaseRepository: getIt()));

}
