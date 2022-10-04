
import '../../injector_container.dart';
import 'data/datasources/network_checker_data_source.dart';
import 'data/repositories/network_checker_repo_impl.dart';
import 'domain/repositories/network_checker_repo.dart';
import 'domain/usecases/network_checker_use_case.dart';
import 'presentation/bloc/network_checker_bloc.dart';


void initNetworkCheckerInjection()  {
  ///Blocs
  getIt.registerFactory<NetworkCheckerBloc>(() => NetworkCheckerBloc(networkCheckerUseCaseImpl: getIt()));

  ///usecases
  getIt.registerLazySingleton<NetworkCheckerUseCaseImpl>(() => NetworkCheckerUseCaseImpl(networkCheckerRepo: getIt()));

  ///Repositories
  getIt.registerLazySingleton<NetworkCheckerRepo>(() => NetworkCheckerRepoImpl(
    networkCheckerDataSource: getIt(),
      ));

  ///DataSources
  getIt.registerLazySingleton<NetworkCheckerDataSource>(() => NetworkCheckerDataSourceImpl(connectivity: getIt()));

}
