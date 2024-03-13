import 'package:meta/meta.dart';
import 'dart:convert';

class ErrorResponseModel {
  final String message;
  final int status;
  final bool success;

  ErrorResponseModel({
    required this.message,
    required this.status,
    required this.success,
  });

  ErrorResponseModel copyWith({
    String? message,
    int? status,
    bool? success,
  }) =>
      ErrorResponseModel(
        message: message ?? this.message,
        status: status ?? this.status,
        success: success ?? this.success,
      );

  factory ErrorResponseModel.fromRawJson(String str) => ErrorResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) => ErrorResponseModel(
    message: json["message"],
    status: json["status"],
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "success": success,
  };
}
