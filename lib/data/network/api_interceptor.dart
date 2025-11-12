import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ApiInterceptor extends Interceptor {
  DateTime? _lastConnectionErrorTime;
  final _connectionErrorCooldown = const Duration(seconds: 5);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final storage = Get.find<GetStorage>();
    final token = storage.read("access_token");

    if (token != null && token.isNotEmpty) {
      options.headers["Authorization"] = "Bearer $token";
    }
    options.headers["Accept"] = "application/json";

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final response = err.response;
    Color failColor = Colors.redAccent;

    if (response != null) {
      switch (response.statusCode) {
        case 200:
          Get.snackbar("Berhasil", response.data["message"] ?? "Operasi berhasil",
              backgroundColor: Colors.green);
          break;
        case 201:
          Get.snackbar(
              "Berhasil Dibuat", response.data["message"] ?? "Data berhasil dibuat",
              backgroundColor: Colors.green);
          break;
        case 400:
          //Ini disable snackbar sertifikat
          if (response.data["message"] == "Sertifikat belum terbit" || response.data["message"] == "Absen tidak lengkap." ) break;
          Get.snackbar("Permintaan Tidak Valid",
              response.data["message"] ?? "Permintaan yang Anda kirim tidak valid",
              backgroundColor: failColor);
          break;
        case 401:
          Get.snackbar("Tidak Memiliki Akses",
              response.data["message"] ?? "Kredensial tidak valid.",
              backgroundColor: failColor);
          break;
        case 403:
          Get.snackbar("Akses Ditolak",
              response.data["message"] ??
                  "Anda tidak memiliki izin untuk melakukan aksi ini",
              backgroundColor: failColor);
          break;
        case 404:
        // Get.snackbar("Tidak Ditemukan", response.data["message"] ?? "Tidak ditemukan");
          break;
        case 422:
          String message =
              response.data["message"] ?? "Data yang dikirim tidak valid";
          if (response.data["errors"] != null) {
            Map<String, dynamic> errors = response.data["errors"];
            errors.forEach((key, value) {
              message += "\n- ${value[0]}";
            });
          }
          Get.snackbar("Data Tidak Valid", message, backgroundColor: failColor);
          break;
        case 500:
          Get.snackbar("Masalah Server",
              response.data["message"] ??
                  "Terjadi masalah pada server, coba lagi nanti",
              backgroundColor: failColor);
          break;
        default:
          Get.snackbar("Terjadi Kesalahan",
              response.data["message"] ??
                  "Telah terjadi kesalahan yang tidak diketahui",
              backgroundColor: failColor);
          break;
      }
    } else {
      final now = DateTime.now();
      if (_lastConnectionErrorTime == null ||
          now.difference(_lastConnectionErrorTime!) > _connectionErrorCooldown) {
        _lastConnectionErrorTime = now;
        Get.snackbar(
          "Masalah Koneksi",
          "Tidak dapat terhubung ke server, periksa koneksi internet Anda",
          backgroundColor: failColor,
        );
      }
    }

    handler.next(err);
  }
}
