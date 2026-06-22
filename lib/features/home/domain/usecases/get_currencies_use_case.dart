import 'package:currency_converter/core/networking/api_result.dart';
import 'package:currency_converter/features/home/data/models/currency_model.dart';
import 'package:currency_converter/features/home/domain/repository/currency_repository.dart';

class GetCurrenciesUseCase {
  final CurrencyRepository repository;

  GetCurrenciesUseCase(this.repository);

  Future<ApiResult<List<CurrencyModel>>> call() async {
    var result = await repository.getCurrencies();

    return result;
  }
}
