import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:frontend_mobile_flutter/modules/auth/auth_controller.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  final AuthController controller = Get.find<AuthController>();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    final email = emailController.text.trim();
    
    // Validasi email kosong
    if (email.isEmpty) {
      Get.snackbar(
        'Peringatan', 
        'Mohon masukkan email Anda terlebih dahulu.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    // Validasi format email
    if (!GetUtils.isEmail(email)) {
      Get.snackbar(
        'Peringatan', 
        'Format email tidak valid.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    setState(() => isLoading = true);
    
    // API CALL - Request OTP ke backend
    final result = await controller.forgotPassword(email);
    
    setState(() => isLoading = false);

    if (result != null) {
      // Gagal - tampilkan error
      Get.snackbar(
        'Gagal', 
        result,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Berhasil',
        'Email reset kata sandi telah dikirim. Silakan cek kotak masuk Anda.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }
  void _goToLoginPage() {
    Get.back(); 
  }
  @override
  Widget build(BuildContext context) {
    bool isForgotPasswordRequestSent = controller.isForgotPasswordRequestSent.value;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false, 
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Get.back(), 
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent, 
        elevation: 0, 
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 16),
            const Text(
              'Lupa Kata Sandi',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E232C),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Masukkan email Anda untuk mendapatkan kode verifikasi.',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF8391A1),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Email',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E232C),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF7F8F9),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE8ECF4)),
              ),
              child: TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                enabled: !isLoading,
                decoration: const InputDecoration(
                  hintText: 'Email', 
                  hintStyle: TextStyle(color: Color(0xFF8391A1)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 16, vertical: 16),
                  prefixIcon: Icon(Icons.person_outline,
                      color: Color(0xFF8391A1)),
                ),
                style: const TextStyle(color: Color(0xFF1E232C)),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: isLoading ? null : controller.isForgotPasswordRequestSent.value ? _goToLoginPage : _onSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1565C0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                  disabledBackgroundColor: Colors.grey,
                ),
                child: isLoading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    :  Text(
                        controller.isForgotPasswordRequestSent.value ? "Kembali Ke Login" : 'Kirim Kode Verifikasi',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 40),
           
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.red.shade400,
                  style: BorderStyle.solid, 
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Tips Keamanan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD32F2F),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Pastikan email yang Anda masukkan adalah email yang terdaftar pada akun Anda. Kode verifikasi akan dikirim ke email tersebut.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFFD32F2F),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}