import 'package:dio/dio.dart';
import 'api_error_model.dart';

class ApiErrorHandler {
  static ApiErrorModel handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return ApiErrorModel(message: "Connection timeout with the server");
        case DioExceptionType.sendTimeout:
          return ApiErrorModel(
            message: "Send timeout in connection with the server",
          );
        case DioExceptionType.receiveTimeout:
          return ApiErrorModel(
            message: "Receive timeout in connection with the server",
          );
        case DioExceptionType.badCertificate:
          return ApiErrorModel(
            message: "Secured connection failed (Bad Certificate)",
          );

        case DioExceptionType.badResponse:
          return _handleError(error.response?.statusCode, error.response?.data);

        case DioExceptionType.cancel:
          return ApiErrorModel(message: "Request to the server was cancelled");
        case DioExceptionType.connectionError:
          return ApiErrorModel(
            message: "Connection to server failed. Please check your internet",
          );
        case DioExceptionType.unknown:
          return ApiErrorModel(message: "An unknown network error occurred");
      }
    } else {
      return ApiErrorModel(message: "An unexpected local error occurred");
    }
  }

  static ApiErrorModel _handleError(int? statusCode, dynamic data) {
    if (data is Map<String, dynamic>) {
      return ApiErrorModel.fromJson(data, statusCode);
    }

    String defaultMessage;
    switch (statusCode) {
      case 400:
        defaultMessage = "Invalid parameter or malformed request.";
        break;
      case 404:
        defaultMessage = "Currency, rate, or resource not found.";
        break;
      case 422:
        defaultMessage = "Request understood but cannot be processed.";
        break;
      default:
        defaultMessage = "Something went wrong. Please try again.";
    }

    return ApiErrorModel(statusCode: statusCode, message: defaultMessage);
  }
}
