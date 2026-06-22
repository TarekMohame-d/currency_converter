import 'package:currency_converter/core/networking/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

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

    _addDioInterceptor(dioInstance);

    return dioInstance;
  }

  static void _addDioInterceptor(Dio dio) {
    dio.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
  }
}
