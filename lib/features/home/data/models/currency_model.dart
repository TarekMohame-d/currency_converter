class CurrencyModel {
  final String isoCode;
  final String isoNumeric;
  final String name;
  final String symbol;
  final String startDate;

  CurrencyModel({
    required this.isoCode,
    required this.isoNumeric,
    required this.name,
    required this.symbol,
    required this.startDate,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      isoCode: json['iso_code'] as String? ?? '',
      isoNumeric: json['iso_numeric'] as String? ?? '',
      name: json['name'] as String? ?? '',
      symbol: json['symbol'] as String? ?? '',
      startDate: json['start_date'] as String? ?? '',
    );
  }
}
