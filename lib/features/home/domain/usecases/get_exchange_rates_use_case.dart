import 'package:currency_converter/core/networking/api_result.dart';
import 'package:currency_converter/features/home/data/models/single_currency_pair_model.dart';
import '../repository/currency_repository.dart';

class GetExchangeRatesUseCase {
  final CurrencyRepository repository;

  GetExchangeRatesUseCase(this.repository);

  Future<ApiResult<SingleCurrencyPairModel>> call(
    String baseCurrency,
    String targetCurrency,
  ) async {
    var result = await repository.getSingleRate(baseCurrency, targetCurrency);

    return result;
  }
}
