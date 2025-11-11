import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/app_colors.dart';
import '../../core/text_styles.dart';
import '../../core/widgets/otp_widgets.dart';
import 'auth_controller.dart';


class OtpVerificationPage extends StatefulWidget {
  final String email;
  final bool isFromRegistration;

  const OtpVerificationPage({
    super.key,
    required this.email,
    this.isFromRegistration = true,
  });

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final AuthController _authController = Get.find<AuthController>();
  String otpCode = '';
  bool isLoading = false;
  int _resendCountdown = 60;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  void _startResendTimer() {
    _canResend = false;
    _resendCountdown = 60;

    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        setState(() {
          _resendCountdown--;
          if (_resendCountdown <= 0) {
            _canResend = true;
          }
        });
      }
      return _resendCountdown > 0 && mounted;
    });
  }

  void _onNumberTap(String value) {
    if (otpCode.length < 6) {
      setState(() {
        otpCode = otpCode + value;
      });

      // Auto submit when 6 digits are entered
      if (otpCode.length == 6) {
        _autoVerifyOtp();
      }
    }
  }

  void _onBackspace() {
    if (otpCode.isNotEmpty) {
      setState(() {
        otpCode = otpCode.substring(0, otpCode.length - 1);
      });
    }
  }

  Future<void> _autoVerifyOtp() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Call API through AuthController
      final error = await _authController.verifyOtp(
        email: widget.email,
        otp: otpCode,
      );
      
      print('OTP Verification Result: ${error == null ? "Success" : "Error: $error"}');
      
      setState(() {
        isLoading = false;
      });

      if (error == null) {
        // Success - OTP verified
        if (widget.isFromRegistration) {
          // Registration flow - go back to login
          Get.offAllNamed('/auth');
          Get.snackbar(
            'Berhasil',
            'Registrasi berhasil! Silakan login',
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
          );
        } else {
          // Forgot password flow - go to reset password
         
        }
      } else {
        // Error - OTP verification failed
        setState(() {
          otpCode = ''; // Clear OTP on error
        });

        Get.snackbar(
          'Gagal',
          error,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }

    } catch (e) {
      setState(() {
        isLoading = false;
        otpCode = ''; // Clear OTP on error
      });

      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
    }
  }

  Future<void> _resendOtp() async {
    if (!_canResend || isLoading) return;

    setState(() {
      isLoading = true;
    });

    final error = await _authController.resendOtp(widget.email);

    setState(() {
      isLoading = false;
    });

    if (error == null) {
      Get.snackbar(
        'Berhasil',
        'Kode OTP telah dikirim ulang ke email Anda',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      _startResendTimer();
    } else {
      Get.snackbar(
        'Error',
        error,
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final boxSize = screenWidth * 0.13;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.primary.withOpacity(0.1),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.primary,
              size: 20,
            ),
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),

                        // Title
                        Text(
                          'Verifikasi Kode',
                          style: TextStyles.headerLarge.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Subtitle
                        Text(
                          'Konfirmasi OTP',
                          style: TextStyles.headerMedium.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Description
                        Text(
                          widget.isFromRegistration
                              ? 'Kami telah mengirim kode verifikasi ke email\nAnda untuk menyelesaikan registrasi'
                              : 'Kami telah mengirim kode ke email\nAnda. Silakan masukkan di sini',
                          textAlign: TextAlign.center,
                          style: TextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Email display
                        Text(
                          widget.email,
                          textAlign: TextAlign.center,
                          style: TextStyles.bodyMedium.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 40),

                        // OTP Boxes
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            6,
                            (index) => Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 3),
                              child: OtpWidgets.buildOtpBox(
                                position: index,
                                otpCode: otpCode,
                                boxSize: boxSize,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Resend OTP Button
                        TextButton(
                          onPressed: _canResend && !isLoading ? _resendOtp : null,
                          child: Text(
                            _canResend
                                ? 'Kirim Ulang Kode'
                                : 'Kirim Ulang dalam $_resendCountdown detik',
                            style: TextStyles.bodyMedium.copyWith(
                              color: _canResend
                                  ? AppColors.primary
                                  : AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),

                // Numeric Keyboard
                OtpWidgets.buildNumericKeyboard(
                  onNumberTap: _onNumberTap,
                  onBackspace: _onBackspace,
                  buttonSize: 70,
                  spacing: 15,
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),

          // Loading Overlay
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ),
            ),
        ],
      ),
    );
  }
}