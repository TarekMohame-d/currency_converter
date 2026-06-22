abstract interface class CurrencyDataSource {
  Future<Map<String, dynamic>> fetchSinglePair(
    String baseCurrency,
    String targetCurrency,
  );

  Future<List<Map<String, dynamic>>> fetchAvailableCurrencies();
}
