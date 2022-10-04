
// import '../../injector_container.dart';
// import 'data/datasources/random_quote_local_data_source.dart';
// import 'data/datasources/random_quote_remote_data_source.dart';
// import 'data/repositories/quote_repository_impl.dart';
// import 'domain/repositories/quote_repository.dart';
// import 'domain/usecases/get_random_quote.dart';
// import 'presentation/cubit/random_quote_cubit.dart';


// void initQuoteInjection()  {
//   ///Blocs
//   getIt.registerFactory<RandomQuoteCubit>(() => RandomQuoteCubit(getRandomQuoteUseCase: getIt()));

//   ///usecases
//   getIt.registerLazySingleton<GetRandomQuote>(() => GetRandomQuote(quoteRepository: getIt()));

//   ///Repositories
//   getIt.registerLazySingleton<QuoteRepository>(() => QuoteRepositoryImpl(
//         networkInfo: getIt(),
//         randomQuoteLocalDataSource: getIt(),
//         randomQuoteRemoteDataSource: getIt(),
//       ));

//   ///DataSources
//   getIt.registerLazySingleton<RandomQuoteLocalDataSource>(() => RandomQuoteLocalDataSourceImpl(sharedPreferences: getIt()));
//   getIt.registerLazySingleton<RandomQuoteRemoteDataSource>(() => RandomQuoteRemoteDataSourceImpl(dioConsumer: getIt()));

// }
