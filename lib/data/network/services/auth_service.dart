import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../models/auth/login_request.dart';
import '../../models/auth/login_response.dart';
import '../../models/auth/otp_resend_request.dart';
import '../../models/auth/otp_verify_request.dart';
import '../../models/auth/register_request.dart';
import '../../models/auth/register_response.dart';
import '../../models/auth/reset_password_request.dart';
import '../../models/auth/forgot_password_request.dart';
import '../../models/basic_response.dart';
import '../api_client.dart';
import '../endpoints.dart';

class AuthService extends GetxService {
  final storage = Get.find<GetStorage>();
  final secure = const FlutterSecureStorage();

  /// Login user
  Future<LoginResponse> login(LoginRequest req) async {
    try {
      final response = await ApiClient.dio.post(
        Endpoints.login,
        data: req.toJson(),
      );

      final model = LoginResponse.fromJson(response.data);

      if (model.success && model.data != null) {
        storage.write("access_token", model.data!.accessToken);
        storage.write("name", model.data!.user.name);
        storage.write("username", model.data!.user.username);
        storage.write("role", model.data!.user.role);
        storage.write("email", model.data!.user.email);
      }

      return model;
    } on DioException catch (e) {
      final body = e.response?.data;

      return LoginResponse(
        success: false,
        message: body?["message"] ?? "Login failed",
      );
    }
  }

  /// Register new user
  Future<RegisterResponse> register(RegisterRequest req) async {
    try {
      final response = await ApiClient.dio.post(
        Endpoints.register,
        data: req.toJson(),
      );

      return RegisterResponse.fromJson(response.data);
    } on DioException catch (e) {
      final res = e.response?.data;

      return RegisterResponse(
        success: false,
        message: res?["message"] ?? "Registration failed",
        errors: res?["errors"],
      );
    }
  }

  /// Forgot Password - Send OTP to email
  Future<BasicResponse> forgotPassword(ForgotPasswordRequest req) async {
    try {
      final res = await ApiClient.dio.post(
        Endpoints.forgotPassword,
        data: req.toJson(),
      );

      return BasicResponse.fromJson(res.data);

    } on DioException catch (e) {
      final data = e.response?.data;
      return BasicResponse(
        success: false,
        message: data?["message"] ?? "Gagal mengirim OTP. Silakan coba lagi.",
      );
    }
  }

  /// Reset Password with OTP token
  Future<BasicResponse> resetPassword(ResetPasswordRequest req) async {
    try {
      final res = await ApiClient.dio.post(
        Endpoints.resetPassword,
        data: req.toJson(),
      );

      return BasicResponse.fromJson(res.data);

    } on DioException catch (e) {
      final data = e.response?.data;
      return BasicResponse(
        success: false,
        message: data?["message"] ?? "Token tidak valid atau sudah kadaluarsa",
      );
    }
  }

  /// Verify OTP
  Future<int?> verifyOtp(OtpVerifyRequest req) async {
    try {
      final response = await ApiClient.dio.post(
        Endpoints.verifyOtp,
        data: req.toJson(),
      );
      
      if (response.statusCode == 200) {
        return 200;
      }
      return null;
      
    } on DioException catch (e) {
      final res = e.response?.data;
      print('OTP Verification Error: ${res?["message"] ?? e.message}');
      return null;
    }
  }

  /// Resend OTP
  Future<BasicResponse> resendOtp(OtpResendRequest req) async {
    try {
      final response = await ApiClient.dio.post(
        Endpoints.resendOtp,
        data: req.toJson(),
      );

      return BasicResponse.fromJson(response.data);
    } on DioException catch (e) {
      final res = e.response?.data;

      return BasicResponse(
        success: false,
        message: res?["message"] ?? "Gagal mengirim ulang OTP",
      );
    }
  }
}