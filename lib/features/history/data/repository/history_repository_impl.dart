import 'package:currency_converter/features/history/data/models/history_rate_model.dart';
import '../../domain/repository/history_repository.dart';
import '../data_source/interfaces/history_currency_data_source.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryCurrencyDataSource dataSource;

  HistoryRepositoryImpl(this.dataSource);

  @override
  Future<List<HistoryRateModel>> getRateHistory() async {
    try {
      final data = await dataSource.getRateHistory();
      return data.map((json) => HistoryRateModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteHistoryItem(int id) async {
    try {
      await dataSource.deleteHistoryItem(id);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> clearHistory() async {
    try {
      return await dataSource.clearHistory();
    } catch (e) {
      return false;
    }
  }
}
