import 'package:currency_converter/features/history/data/models/history_rate_model.dart';

abstract class HistoryRepository {
  Future<List<HistoryRateModel>> getRateHistory();
  Future<bool> deleteHistoryItem(int id);
  Future<bool> clearHistory();
}
