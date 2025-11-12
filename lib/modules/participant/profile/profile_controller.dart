import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/models/profile/change_password_request.dart';
import '../../../data/models/profile/update_profile_request.dart';
import '../../../data/network/services/profile_service.dart';

// Controller untuk mengelola state dan logika halaman profil.
class ProfileController extends GetxController {
  // -- DEPENDENCIES --
  final _storage = Get.find<GetStorage>();
  final _profileService = Get.find<ProfileService>();

  // -- STATE REAKTIF (.obs) --
  final RxBool isLoggedIn = false.obs;
  final RxBool isLoading = false.obs;
  final RxString profileImageUrl = ''.obs; // Menyimpan URL gambar dari server.
  final Rx<File?> profileImageFile = Rx<File?>(null); // Menyimpan file gambar lokal yang aktif.
  final RxString name = ''.obs; // Menyimpan nama pengguna.
  final RxString whatsapp = ''.obs; // Menyimpan nomor whatsapp pengguna.
  final RxString email = ''.obs; // Menyimpan email pengguna.

  // State untuk pratinjau gambar di dialog.
  final Rx<File?> selectedImageFile = Rx<File?>(null);

  // State untuk visibilitas password di dialog.
  final RxBool isCurrentPasswordObscured = true.obs;
  final RxBool isNewPasswordObscured = true.obs;
  final RxBool isConfirmPasswordObscured = true.obs;

  // -- TEXT CONTROLLERS --
  // Untuk mendapatkan input dari kolom teks.
  late TextEditingController nameController;
  late TextEditingController whatsappController;
  late TextEditingController emailController;
  late TextEditingController currentPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;

  // Metode yang dijalankan saat controller pertama kali diinisialisasi.
  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    whatsappController = TextEditingController();
    emailController = TextEditingController();
    currentPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    // Listen for changes in the access_token and update login status
    _storage.listenKey('access_token', (value) {
      checkLoginStatus();
    });

    checkLoginStatus();

    if (isLoggedIn.value) {
      fetchUserProfile(); // Mengambil data profil awal jika sudah login.
    }
  }

  void checkLoginStatus() {
    final token = _storage.read('access_token');
    isLoggedIn.value = token != null && token.isNotEmpty;
  }

  // Metode yang dijalankan saat controller akan dihapus.
  @override
  void onClose() {
    nameController.dispose();
    whatsappController.dispose();
    emailController.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  // --- FUNGSI-FUNGSI LOGIKA --

  // Mengambil data profil awal (saat ini masih simulasi).
  Future<void> fetchUserProfile() async {
    isLoading.value = true;
    try {
      final response = await _profileService.getProfile();
      if (response.success) {
        final profile = response.data!;
        profileImageUrl.value = profile.profilePhoto ?? '';
        name.value = profile.name;
        whatsapp.value = profile.telp;
        email.value = profile.email;
      } else {
        Get.snackbar('Gagal', response.message, backgroundColor: Colors.red, colorText: Colors.white);
      }
    } finally {
      isLoading.value = false;
    }
  }

  // Menginisialisasi form edit dengan data saat ini.
  void initEditForm() {
    nameController.text = name.value;
    whatsappController.text = whatsapp.value;
    emailController.text = email.value;
    selectedImageFile.value = null;
  }

  // Mereset form ubah password sebelum dialog muncul.
  void initChangePasswordForm() {
    currentPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
    isCurrentPasswordObscured.value = true;
    isNewPasswordObscured.value = true;
    isConfirmPasswordObscured.value = true;
  }

  // Membuka galeri untuk memilih gambar.
  Future<void> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      selectedImageFile.value = File(image.path);
    } else {
      print('No image selected.');
    }
  }

  // Logika untuk menyimpan perubahan profil.
  Future<void> updateProfile() async {
    isLoading.value = true;
    try {
      final request = UpdateProfileRequest(
        name: nameController.text,
        telp: whatsappController.text,
        profilePhoto: selectedImageFile.value,
      );

      final response = await _profileService.updateProfile(request);

      if (response.success) {
        if (selectedImageFile.value != null) {
          profileImageFile.value = selectedImageFile.value;
          profileImageUrl.value = '';
        }

        name.value = nameController.text;
        whatsapp.value = whatsappController.text;
        email.value = emailController.text;
        _storage.write("status_karyawan", response.data?.statusKaryawan ?? 0);

        Get.back(); // Menutup dialog.
        Get.snackbar('Berhasil', 'Profil berhasil diperbarui.', backgroundColor: Colors.green, colorText: Colors.white);
      }
    } finally {
      isLoading.value = false;
    }
  }

  // Logika untuk menyimpan kata sandi baru.
  Future<void> changePassword() async {
    if (newPasswordController.text != confirmPasswordController.text) {
      Get.snackbar('Gagal', 'Password baru tidak cocok.', backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    if (currentPasswordController.text.isEmpty) {
      Get.snackbar('Gagal', 'Password saat ini tidak boleh kosong.', backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    if (newPasswordController.text.isEmpty) {
      Get.snackbar('Gagal', 'Password baru tidak boleh kosong.', backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isLoading.value = true;
    try {
      final request = ChangePasswordRequest(
        currentPassword: currentPasswordController.text,
        newPassword: newPasswordController.text,
        newPasswordConfirmation: confirmPasswordController.text,
      );
      final response = await _profileService.changePassword(request);

      if (response.success) {
        Get.back(); // Menutup dialog.
        Get.snackbar('Berhasil', 'Kata sandi berhasil diubah.', backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar('Gagal', response.message, backgroundColor: Colors.red, colorText: Colors.white);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    isLoading.value = true;
    try {
      final response = await _profileService.logout();
      if (response.success) {
        checkLoginStatus();
        Get.snackbar('Berhasil', 'Anda berhasil keluar.', backgroundColor: Colors.green, colorText: Colors.white);
        Get.offAllNamed('/login');
      }
    } finally {
      isLoading.value = false;
    }
  }
}
