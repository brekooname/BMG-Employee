
import '../../injector_container.dart';
import 'data/datasources/get_version_data_source.dart';
import 'data/repositories/get_version_repo_impl.dart';
import 'domain/repositories/get_version_repo.dart';
import 'domain/usecases/get_version_use_case.dart';
import 'presentation/cubit/get_version_cubit.dart';


void initGetVersionInjection()  {
  ///Blocs
  getIt.registerFactory<GetVersionCubit>(() => GetVersionCubit(getVersionUseCaseImpl: getIt()));

  ///usecases
  getIt.registerLazySingleton<GetVersionUseCaseImpl>(() => GetVersionUseCaseImpl(getVersionRepo: getIt()));

  ///Repositories
  getIt.registerLazySingleton<GetVersionRepo>(() => GetVersionRepoImpl(
        getVersionDataSourceImpl: getIt(),
        networkInfo: getIt(),
      ));

  ///DataSources
  getIt.registerLazySingleton<GetVersionDataSourceImpl>(() => GetVersionDataSourceImpl(firebaseRepository: getIt()));

}
