import 'package:currency_converter/core/services/sql_helper.dart';
import 'package:currency_converter/features/home/data/data_source/interfaces/currency_data_source.dart';

class CurrencyLocalDataSource implements CurrencyDataSource {
  @override
  Future<Map<String, dynamic>> fetchSinglePair(
    String base,
    String target,
  ) async {
    final List<Map<String, dynamic>> results = await SQLHelper.getItemsByBase(
      base,
    );

    return results.firstWhere(
      (element) => element['quote'] == target,
      orElse: () => {},
    );
  }

  @override
  Future<List<Map<String, dynamic>>> fetchAvailableCurrencies() async {
    return await SQLHelper.getOfflineCurrencies();
  }

  Future<void> cacheSinglePair(Map<String, dynamic> data) async {
    await SQLHelper.insert(data);
  }

  Future<void> cacheAvailableCurrencies(
    List<Map<String, dynamic>> currencies,
  ) async {
    await SQLHelper.insertCurrencies(currencies);
  }
}
