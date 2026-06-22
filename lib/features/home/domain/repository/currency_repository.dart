import 'package:currency_converter/core/networking/api_result.dart';
import 'package:currency_converter/features/home/data/models/conversion_log_model.dart';
import 'package:currency_converter/features/home/data/models/currency_model.dart';
import 'package:currency_converter/features/home/data/models/single_currency_pair_model.dart';

abstract class CurrencyRepository {
  Future<ApiResult<SingleCurrencyPairModel>> getSingleRate(
    String baseCurrency,
    String targetCurrency,
  );
  Future<ApiResult<List<CurrencyModel>>> getCurrencies();
  Future<void> saveConversionLog(ConversionLogModel log);
}
