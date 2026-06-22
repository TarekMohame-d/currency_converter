class ApiErrorModel {
  final int? statusCode;
  final String message;

  ApiErrorModel({this.statusCode, required this.message});

  factory ApiErrorModel.fromJson(Map<String, dynamic> json, int? statusCode) {
    return ApiErrorModel(
      statusCode: statusCode,
      message: json['message'] as String? ?? "An unexpected error occurred",
    );
  }
}
