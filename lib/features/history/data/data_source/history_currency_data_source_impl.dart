import 'package:currency_converter/core/services/sql_helper.dart';
import 'package:currency_converter/features/history/data/data_source/interfaces/history_currency_data_source.dart';

class HistoryCurrencyDataSourceImpl implements HistoryCurrencyDataSource {
  @override
  Future<List<Map<String, dynamic>>> getRateHistory() async {
    return await SQLHelper.getAllDBItems();
  }

  @override
  Future<void> deleteHistoryItem(int id) async {
    await SQLHelper.delete(id);
  }

  @override
  Future<bool> clearHistory() async {
    return await SQLHelper.clear();
  }
}
