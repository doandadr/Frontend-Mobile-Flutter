import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiInterceptor extends Interceptor {
  // final secure = const FlutterSecureStorage();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Use Get.find() to ensure the same instance is used everywhere.
    final storage = Get.find<GetStorage>();
    final token = storage.read("access_token");

    if (token != null && token.isNotEmpty) {
      options.headers["Authorization"] = "Bearer $token";
    }
    options.headers["Accept"] = "application/json";
    // TODO check if unneeded header returns error

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    final response = err.response;
    Color failColor = Colors.redAccent;
    if (response != null) {
      switch (response.statusCode) {
        case 400:
          // TODO make sure response data message never null
          Get.snackbar("Bad Request", response.data["message"] ?? "Invalid request",backgroundColor: failColor);
          break;
        case 401:
          Get.snackbar("Unauthorized", response.data["message"] ?? "Invalid credentials",backgroundColor: failColor);
          break;
        case 403:
          Get.snackbar("Forbidden", response.data["message"] ?? "Not allowed",backgroundColor: failColor);
          break;
        case 404:
          // Get.snackbar("Not Found", response.data["message"] ?? "Not found"); DISABLE SEMENTARA KARENA DETAIL ADA DIBILANG 404
          break;
        case 422:
          Get.snackbar("Unprocessable Entity", response.data["message"] ?? "Invalid request",backgroundColor: failColor);
          break;
        case 500:
          Get.snackbar("Internal Server Error", response.data["message"] ?? "Internal server error",backgroundColor: failColor);
          break;
        default:
          Get.snackbar("Unknown Error", response.data["message"] ?? "Something went wrong",backgroundColor: failColor);
          break;
      }
    } else {
      Get.snackbar("Connection Error", "Network unavailable",backgroundColor: failColor);
    }

    handler.next(err);
  }
}
