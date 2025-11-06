import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:frontend_mobile_flutter/modules/auth/otp_verification_page.dart';


class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

    return Scaffold(
      // AppBar dengan tombol kembali
      appBar: AppBar(
        automaticallyImplyLeading: false, 
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(), 
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent, 
        elevation: 0, 
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
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
                color: Color(0xFF1E232C), // Warna teks utama
              ),
            ),
            const SizedBox(height: 8),
            // Deskripsi
            const Text(
              'Masukkan email Anda untuk mendapatkan instruksi reset kata sandi.',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF8391A1), // Warna teks deskripsi
              ),
            ),
            const SizedBox(height: 32),
            // Label Email
            const Text(
              'Email',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E232C),
              ),
            ),
            const SizedBox(height: 8),
            // Input Email
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF7F8F9), // Warna latar belakang input
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE8ECF4)),
              ),
              child: TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
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
            // Tombol Dapatkan Instruksi
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  final email = emailController.text.trim();
                  
                  if (email.isEmpty) {
                    Get.snackbar(
                      'Peringatan', 
                      'Mohon masukkan email Anda terlebih dahulu.',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  } else {
                    Get.to(() => OtpVerificationPage(email: email));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1565C0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Dapatkan Instruksi',
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Tips Kata Sandi',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD32F2F),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Buat kata sandi yang mudah diingat dan aman untuk mengurangi kebutuhan melakukan reset.',
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