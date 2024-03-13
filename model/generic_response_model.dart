import 'package:meta/meta.dart';
import 'dart:convert';

class GenericResponseModel {
  final String message;
  final int status;
  final bool success;

  GenericResponseModel({
    required this.message,
    required this.status,
    required this.success,
  });

  GenericResponseModel copyWith({
    String? message,
    int? status,
    bool? success,
  }) =>
      GenericResponseModel(
        message: message ?? this.message,
        status: status ?? this.status,
        success: success ?? this.success,
      );

  factory GenericResponseModel.fromRawJson(String str) => GenericResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GenericResponseModel.fromJson(Map<String, dynamic> json) => GenericResponseModel(
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
