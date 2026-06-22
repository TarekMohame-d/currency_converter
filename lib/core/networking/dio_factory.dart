import 'package:currency_converter/core/networking/api_constants.dart';
import 'package:dio/dio.dart';

class DioFactory {
  DioFactory._();

  static Dio? _dio;

  static Dio get dio {
    _dio ??= _initDio();
    return _dio!;
  }

  static Dio _initDio() {
    final baseOptions = BaseOptions(
      baseUrl: KApiConstants.apiBaseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {'accept': 'application/json'},
    );

    final dioInstance = Dio(baseOptions);

    return dioInstance;
  }
}
