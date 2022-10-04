// import 'package:dartz/dartz.dart';
// import '../../../../core/error/exceptions.dart';
// import '../../../../core/error/failures.dart';
// import '../../domain/entities/quote.dart';
// import '../../domain/repositories/quote_repository.dart';
// import '../datasources/random_quote_local_data_source.dart';
// import '../datasources/random_quote_remote_data_source.dart';

// class QuoteRepositoryImpl implements QuoteRepository {
//   final RandomQuoteRemoteDataSource randomQuoteRemoteDataSource;
//   final RandomQuoteLocalDataSource randomQuoteLocalDataSource;

//   QuoteRepositoryImpl({
//     required this.randomQuoteRemoteDataSource,
//     required this.randomQuoteLocalDataSource,
//   });
//   @override
//   Future<Either<Failure, Quote>> getRandomQuote() async {
//       try {
//         final remoteRandomQuote =
//             await randomQuoteRemoteDataSource.getRandomQuote();
//         randomQuoteLocalDataSource.chacheQuote(remoteRandomQuote);
//         return Right(remoteRandomQuote);
//       } on ServerException {
//         return Left(ServerFailure());
//       }
//     } else {
//       try {
//         final cacheRandomQuote =
//             await randomQuoteLocalDataSource.getLastRandomQuote();
//         return Right(cacheRandomQuote);
//       } on CacheException {
//         return Left(CacheFailure());
//       }
//     }
//   }
// }
