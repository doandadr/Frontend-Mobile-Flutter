import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend_mobile_flutter/modules/participant/profile/profile_controller.dart';
import 'package:get/get.dart';

// Widget untuk menampilkan satu baris informasi profil (label dan value).
class ProfileInfoTile extends StatelessWidget {
  final String label;
  final String value;

  const ProfileInfoTile({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child:Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),),
        ),
      ],
    );
  }
}

// Widget dialog untuk mengedit data profil pengguna.
class EditProfileDialog extends GetView<ProfileController> {
  const EditProfileDialog({super.key});

  @override
  Widget build(BuildContext context) {
    // Efek blur pada latar belakang saat dialog muncul.
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        // Membuat konten dialog dapat di-scroll.
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Edit Data',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                const Center(
                  child: Text(
                    'Ubah Foto',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  // Menangkap aksi ketuk untuk memilih gambar dari galeri.
                  child: GestureDetector(
                    onTap: () {
                      controller.pickImageFromGallery();
                    },
                    // Obx membuat widget ini reaktif terhadap perubahan state gambar.
                    child: Obx(() {
                      ImageProvider? dialogImage;
                      if (controller.selectedImageFile.value != null) {
                        dialogImage = FileImage(controller.selectedImageFile.value!);
                      } else if (controller.profileImageFile.value != null) {
                        dialogImage = FileImage(controller.profileImageFile.value!);
                      } else if (controller.profileImageUrl.isNotEmpty) {
                        dialogImage = NetworkImage(controller.profileImageUrl.value);
                      }

                      // Stack untuk menumpuk ikon kamera di atas avatar.
                      return Stack(
                        children: [
                          CircleAvatar(
                            radius: 55,
                            backgroundColor: Colors.grey[200],
                            backgroundImage: dialogImage,
                            child: (dialogImage == null)
                                ? Icon(
                                    Icons.person,
                                    size: 60,
                                    color: Colors.grey[400],
                                  )
                                : null,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                                decoration: const BoxDecoration(
                                    color: Color(0xFF175FA4), shape: BoxShape.circle),
                                child: const Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                )),
                          )
                        ],
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 24),
                // Kolom input reusable untuk form.
                _EditField(
                    label: 'Nama Lengkap', hint: 'Nama Lengkap baru...', controller: controller.nameController),
                const SizedBox(height: 16),
                _EditField(
                    label: 'No. Whatsapp', hint: 'No. Whatsapp baru...', controller: controller.whatsappController),
                // const SizedBox(height: 16),
                // _EditField(label: 'Email', hint: 'Email baru...', controller: controller.emailController),
                const SizedBox(height: 24),
                // Tombol untuk menyimpan semua perubahan.
                ElevatedButton(
                  onPressed: controller.updateProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF175FA4),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Simpan Perubahan Data',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Widget private untuk kolom input teks pada form.
class _EditField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;

  const _EditField({required this.label, required this.hint, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          // Menentukan tipe keyboard (angka untuk Whatsapp).
          keyboardType: label == 'No. Whatsapp'
              ? TextInputType.number
              : TextInputType.text,
          // Memfilter input agar hanya menerima digit angka.
          inputFormatters: label == 'No. Whatsapp'
              ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
              : [],
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }
}


// Widget dialog untuk mengubah kata sandi pengguna.
class ChangePasswordDialog extends GetView<ProfileController> {
  const ChangePasswordDialog({super.key});

  @override
  Widget build(BuildContext context) {
    // Efek blur pada latar belakang saat dialog muncul.
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        // Membuat konten dialog dapat di-scroll.
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Ubah Kata Sandi',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Kata Sandi Saat Ini',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Obx(() => TextField(
                      controller: controller.currentPasswordController,
                      obscureText: controller.isCurrentPasswordObscured.value,
                      decoration: InputDecoration(
                        hintText: 'Masukkan password saat ini',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isCurrentPasswordObscured.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey[600],
                          ),
                          onPressed: () {
                            controller.isCurrentPasswordObscured.toggle();
                          },
                        ),
                      ),
                    )),
                const SizedBox(height: 16),
                Text(
                  'Kata Sandi Baru',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                // Obx membuat TextField reaktif terhadap perubahan visibilitas.
                Obx(() => TextField(
                      controller: controller.newPasswordController,
                      obscureText: controller.isNewPasswordObscured.value,
                      decoration: InputDecoration(
                        hintText: 'Masukkan password baru',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        // Ikon mata untuk toggle visibilitas password.
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isNewPasswordObscured.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey[600],
                          ),
                          onPressed: () {
                            controller.isNewPasswordObscured.toggle();
                          },
                        ),
                      ),
                    )),
                const SizedBox(height: 16),
                Text(
                  'Ketik Ulang Password Baru',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                // Obx membuat TextField reaktif terhadap perubahan visibilitas.
                Obx(() => TextField(
                      controller: controller.confirmPasswordController,
                      obscureText: controller.isConfirmPasswordObscured.value,
                      decoration: InputDecoration(
                        hintText: 'Konfirmasi password baru',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        // Ikon mata untuk toggle visibilitas password.
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isConfirmPasswordObscured.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey[600],
                          ),
                          onPressed: () {
                            controller.isConfirmPasswordObscured.toggle();
                          },
                        ),
                      ),
                    )),
                const SizedBox(height: 24),
                // Tombol untuk menyimpan kata sandi baru.
                ElevatedButton(
                  onPressed: controller.changePassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF175FA4),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Simpan Kata Sandi',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
