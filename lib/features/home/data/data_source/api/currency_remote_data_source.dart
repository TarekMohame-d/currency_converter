import 'package:currency_converter/features/home/data/data_source/interfaces/currency_data_source.dart';
import 'package:dio/dio.dart';

class CurrencyRemoteDataSource implements CurrencyDataSource {
  final Dio _dio;

  CurrencyRemoteDataSource(this._dio);

  @override
  Future<Map<String, dynamic>> fetchSinglePair(
    String baseCurrency,
    String targetCurrency,
  ) async {
    final response = await _dio.get('/rate/$baseCurrency/$targetCurrency');
    return response.data;
  }

  @override
  Future<List<Map<String, dynamic>>> fetchAvailableCurrencies() async {
    final response = await _dio.get('/currencies');

    final List<dynamic> rawList = response.data;

    return rawList.map((item) => item as Map<String, dynamic>).toList();
  }
}
