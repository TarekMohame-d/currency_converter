class SingleCurrencyPairModel {
  final String date;
  final String base;
  final String quote;
  final double rate;

  const SingleCurrencyPairModel({
    required this.date,
    required this.base,
    required this.quote,
    required this.rate,
  });

  factory SingleCurrencyPairModel.fromJson(Map<String, dynamic> json) {
    final rateValue = (json['rate'] as num).toDouble();

    return SingleCurrencyPairModel(
      base: json['base'] as String,
      date: json['date'] as String,
      quote: json['quote'] as String,
      rate: rateValue,
    );
  }
}
