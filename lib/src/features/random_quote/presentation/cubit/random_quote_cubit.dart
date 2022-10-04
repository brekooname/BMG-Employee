
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/useCases/usecase.dart';
import '../../../../core/utils/app_strings.dart';
import '../../domain/entities/quote.dart';
import '../../domain/usecases/get_random_quote.dart';

part 'random_quote_state.dart';

class RandomQuoteCubit extends Cubit<RandomQuoteState> {
  final GetRandomQuote getRandomQuoteUseCase;
  RandomQuoteCubit({required this.getRandomQuoteUseCase}) : super(RandomQuoteInitial());

  Future<void> getRandomQuote()async{
    emit(RandomQuoteIsLoading());
    Either<Failure,Quote> response= await getRandomQuoteUseCase.call(NoParams());
    emit(response.fold((failure) => RandomQuoteFailure(message:_mapFailureToString(failure) ), (quote) => RandomQuoteIsLoaded(quote: quote)));
  }

   String _mapFailureToString(Failure failure){
      switch(failure.runtimeType){
        case ServerFailure:return AppStrings.serverFailure;
        case CacheFailure:return AppStrings.cacheFailure;
        default:return AppStrings.unexpectedFailure;
      }
    }
}
