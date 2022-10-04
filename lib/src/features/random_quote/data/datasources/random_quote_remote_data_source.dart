import '../../../../core/api/dio_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../models/quote_model.dart';

abstract class RandomQuoteRemoteDataSource {
  Future<QuoteModel> getRandomQuote();
}

class RandomQuoteRemoteDataSourceImpl implements RandomQuoteRemoteDataSource {
  DioConsumer dioConsumer;
  RandomQuoteRemoteDataSourceImpl({required this.dioConsumer});
  @override
  Future<QuoteModel> getRandomQuote() async {
    final json = await dioConsumer.get(
      EndPoints.randomQuote,
    );
    return QuoteModel.fromJson(json);
  }
}
