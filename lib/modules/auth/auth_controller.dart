import 'package:frontend_mobile_flutter/data/models/auth/forgot_password_request.dart';
import 'package:frontend_mobile_flutter/data/models/auth/login_request.dart';
import 'package:frontend_mobile_flutter/data/models/auth/otp_resend_request.dart';
import 'package:frontend_mobile_flutter/data/models/auth/otp_verify_request.dart';
import 'package:frontend_mobile_flutter/data/models/auth/register_request.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../data/models/auth/user.dart';
import '../../data/network/services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService authService = Get.find<AuthService>();
  final storage = GetStorage();

  // Observable user state
  RxBool isLoggedIn = false.obs;
  RxString currentEmail = ''.obs;


  /// LOGIN
  /// Called from flutter_login.onLogin
  /// Return null on success → flutter_login continues
  /// Return string on error   → flutter_login shows error
  Future<String?> login(String login, String password) async {
    final result = await authService.login(
      LoginRequest(login: login, password: password),
    );

    if (!result.success) {
      return result.message;
    }

    // // Persist auth session
    // storage.write("access_token", result.data?.accessToken);
    // storage.write("email", result.data?.user.email);

    currentEmail.value = result.data!.user.email;
    isLoggedIn.value = true;

    return null; // Success
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
    required int statusKaryawan,
  }) async {
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

    if (!result.success) {
      return result.message + result.errors.toString();
    }

    return null;
  }

  /// FORGOT PASSWORD
  /// Called from flutter_login.onRecoverPassword
  Future<String?> forgotPassword(String email) async {
    final result = await authService.forgotPassword(
      ForgotPasswordRequest(email: email),
    );

    if (!result.success) {
      return result.message;
    }

    return null;
  }

  Future<String?> verifyOtp({
    required String email,
    required String otp,
  }) async {
    final result = await authService.verifyOtp(
      OtpVerifyRequest(email: email, otp: otp),
    );

    if (result == 200) {
      return 'Success';
    }
    return null;
  }

  Future<String?> resendOtp(String email) async {
    final result = await authService.resendOtp(OtpResendRequest(email: email));

    if (!result.success) {
      return result.message;
    }

    return null;
  }
  //
  // /// RESTORE SESSION (optional: call on splash)
  // Future<void> tryRestoreSession() async {
  //   final token = storage.read("access_token");
  //   final email = await storageService.getUser();
  //
  //   if (token != null && user != null) {
  //     currentUser.value = user;
  //     isLoggedIn.value = true;
  //   }
  // }

  /// LOGOUT
  //   Future<void> logout() async {
  //     await storageService.clear();
  //     currentUser.value = null;
  //     isLoggedIn.value = false;
  //
  //     // Navigate to auth route
  //     Get.offAllNamed('/auth');
  //   }
  // }
}
