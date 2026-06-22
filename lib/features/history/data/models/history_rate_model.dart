class HistoryRateModel {
  final int? id;
  final String date;
  final String base;
  final String quote;
  final double rate;
  final double amount;

  HistoryRateModel({
    this.id,
    required this.date,
    required this.base,
    required this.quote,
    required this.rate,
    required this.amount,
  });

  factory HistoryRateModel.fromJson(Map<String, dynamic> json) {
    return HistoryRateModel(
      id: json['id'] as int?,
      date: json['date'] as String? ?? '',
      base: json['base'] as String? ?? '',
      quote: json['quote'] as String? ?? '',
      rate: (json['rate'] as num? ?? 0.0).toDouble(),
      amount: (json['amount'] as num? ?? 1.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'date': date,
      'base': base,
      'quote': quote,
      'rate': rate,
      'amount': amount,
    };
  }
}
