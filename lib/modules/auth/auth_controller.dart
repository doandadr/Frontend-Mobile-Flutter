import 'package:flutter/foundation.dart';
import 'package:frontend_mobile_flutter/data/models/auth/forgot_password_request.dart';
import 'package:frontend_mobile_flutter/data/models/auth/login_request.dart';
import 'package:frontend_mobile_flutter/data/models/auth/otp_resend_request.dart';
import 'package:frontend_mobile_flutter/data/models/auth/otp_verify_request.dart';
import 'package:frontend_mobile_flutter/data/models/auth/register_request.dart';
import 'package:frontend_mobile_flutter/data/models/auth/reset_password_request.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../data/models/auth/user.dart';
import '../../data/network/services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService authService = Get.find<AuthService>();
  final storage = Get.find<GetStorage>();

  // Observable user state
  RxBool isLoggedIn = false.obs;
  RxBool isForgotPasswordRequestSent = false.obs;
  RxString currentEmail = ''.obs;

  /// LOGIN
  /// Called from flutter_login.onLogin
  /// Return null on success → flutter_login continues
  /// Return string on error   → flutter_login shows error
  Future<String?> login(String login, String password) async {
    try {
      final result = await authService.login(
        LoginRequest(login: login, password: password),
      );

      if (!result.success) {
        return result.message ?? 'Login gagal';
      }

      // Persist auth session
      // storage.write("access_token", result.data?.accessToken);
      // storage.write("email", result.data?.user.email);

      currentEmail.value = result.data!.user.email;
      isLoggedIn.value = true;

      return null; // Success
    } catch (e) {
      return 'Error: $e';
    }
  }

  /// SIGNUP
  /// Called from flutter_login.onSignup
  Future<String?> register({
    required String name,
    required String username,
    required String email,
    required String telp,
    required String password,
    required String confirmPassword,
    required String statusKaryawan,
  }) async {
    try {
      final result = await authService.register(
        RegisterRequest(
          name: name,
          username: username,
          email: email,
          telp: telp,
          password: password,
          passwordConfirmation: confirmPassword,
          statusKaryawan: statusKaryawan,
        ),
      );
      
      print('register result: $result');
      print('status karyawan: $statusKaryawan');
      
      if (!result.success) {
        return result.message ?? 'Registrasi gagal';
      }

      return null; // Success
    } catch (e) {
      return 'Error: $e';
    }
  }

  /// FORGOT PASSWORD - Send OTP to email
  /// Called from flutter_login.onRecoverPassword
  /// Returns null if success, error message if failed
  Future<String?> forgotPassword(String email) async {
    try {
      final result = await authService.forgotPassword(
        ForgotPasswordRequest(email: email),
      );

      if (!result.success) {
        isForgotPasswordRequestSent.value = false;
        return result.message ?? 'Gagal mengirim OTP';
      }

      isForgotPasswordRequestSent.value = true;
      return null; // Success
    } catch (e) {
      return 'Error: $e';
    }
  }

  /// VERIFY OTP
  /// Returns null if success, error message if failed
  Future<String?> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final result = await authService.verifyOtp(
        OtpVerifyRequest(email: email, otp: otp),
      );

      if (result == 200) {
        return null; // ✅ FIXED: return null instead of 'Success'
      }
      return 'Kode OTP tidak valid atau sudah kadaluarsa';
    } catch (e) {
      return 'Error: $e';
    }
  }

  /// RESEND OTP
  /// Returns null if success, error message if failed
  Future<String?> resendOtp(String email) async {
    try {
      final result = await authService.resendOtp(
        OtpResendRequest(email: email)
      );

      if (!result.success) {
        return result.message ?? 'Gagal mengirim ulang OTP';
      }

      return null; // Success
    } catch (e) {
      return 'Error: $e';
    }
  }

  /// RESET PASSWORD (untuk Forgot Password flow)
  /// Returns null if success, error message if failed
  Future<String?> resetPassword(ResetPasswordRequest request) async {
    try {
      final result = await authService.resetPassword(request);

      if (!result.success) {
        return result.message ?? 'Gagal mengubah kata sandi';
      }

      return null; // Success
    } catch (e) {
      return 'Error: $e';
    }
  }

  /// CHANGE PASSWORD (untuk Profile flow)
  /// Returns null if success, error message if failed
  Future<String?> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      // TODO: Buat model ChangePasswordRequest jika belum ada
      // TODO: Buat method changePassword di AuthService
      
      // Sementara - simulasi API call
      // Uncomment ketika backend & model sudah ready:
      /*
      final result = await authService.changePassword(
        ChangePasswordRequest(
          oldPassword: oldPassword,
          newPassword: newPassword,
          confirmPassword: confirmPassword,
        ),
      );

      if (!result.success) {
        return result.message ?? 'Gagal mengubah kata sandi';
      }
      */

      // SIMULASI - hapus ini ketika sudah ada API
      await Future.delayed(const Duration(seconds: 1));
      print('Change Password: old=$oldPassword, new=$newPassword');
      
      return null; // Success
    } catch (e) {
      return 'Error: $e';
    }
  }

  /// RESTORE SESSION (optional: call on splash)
  // Future<void> tryRestoreSession() async {
  //   final token = storage.read("access_token");
  //   final email = storage.read("email");
  //
  //   if (token != null && email != null) {
  //     currentEmail.value = email;
  //     isLoggedIn.value = true;
  //   }
  // }

  /// LOGOUT
  // Future<void> logout() async {
  //   await storage.remove("access_token");
  //   await storage.remove("email");
  //   currentEmail.value = '';
  //   isLoggedIn.value = false;
  //
  //   // Navigate to auth route
  //   Get.offAllNamed('/auth');
  // }
}