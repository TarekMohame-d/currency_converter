class ConversionLogModel {
  final int? id;
  final String date;
  final String base;
  final String quote;
  final double rate;
  final double amount;

  ConversionLogModel({
    this.id,
    required this.date,
    required this.base,
    required this.quote,
    required this.rate,
    required this.amount,
  });

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
