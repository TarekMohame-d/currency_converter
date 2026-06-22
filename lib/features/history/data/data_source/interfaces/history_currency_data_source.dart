abstract class HistoryCurrencyDataSource {
  Future<List<Map<String, dynamic>>> getRateHistory();
  Future<void> deleteHistoryItem(int id);
  Future<bool> clearHistory();
}
