
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/useCases/usecase.dart';
import '../entities/quote.dart';
import '../repositories/quote_repository.dart';

///case of no params
class GetRandomQuote implements UseCase<Quote,NoParams>{
  final QuoteRepository quoteRepository;
  GetRandomQuote({required this.quoteRepository});
  @override
  Future<Either<Failure, Quote>> call(NoParams params) {
   return quoteRepository.getRandomQuote();
  }
}
///
///
///
///
///
///
///
///

///case that we need params
class GetRandomQuoteWithParams implements UseCase<Quote,LoginParams>{
  // final LoginRepo loginRepo;
  @override
  Future<Either<Failure, Quote>> call(LoginParams loginParams) {
    // return LoginRepo.get(params.password);
    throw UnimplementedError();
  }
}
class LoginParams extends Equatable{
  final String username;
  final String password;

  const LoginParams({required this.username,required this.password});
  
  @override
  List<Object?> get props => [username,password];
}