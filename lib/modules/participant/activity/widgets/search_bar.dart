import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../activity_controller.dart';

// Mengubah widget menjadi StatefulWidget untuk mengelola state internal.
class TSearchBar extends StatefulWidget {
  const TSearchBar({super.key});

  @override
  State<TSearchBar> createState() => _TSearchBarState();
}

class _TSearchBarState extends State<TSearchBar> {
  // Membuat TextEditingController untuk mengontrol teks di dalam TextFormField.
  final TextEditingController _textController = TextEditingController();
  // Menghubungkan ke ActivityController yang sudah ada.
  final ActivityController _activityController = Get.find<ActivityController>();

  @override
  void initState() {
    super.initState();
    // Menambahkan listener untuk mendeteksi perubahan pada teks.
    // Setiap kali teks berubah, kita memanggil setState() untuk membangun ulang UI (menampilkan/menyembunyikan tombol 'x').
    _textController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // Selalu dispose controller untuk mencegah memory leak.
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // Menggunakan controller yang sudah kita buat.
      controller: _textController,
      // Tetap melaporkan perubahan teks ke ActivityController agar fungsi pencarian tetap berjalan.
      onChanged: _activityController.updateSearchQuery,
      decoration: InputDecoration(
        hintText: 'Aktivitas...',
        prefixIcon: Icon(
          Icons.search,
          color: Colors.grey[500],
        ),
        // Menampilkan ikon 'x' hanya jika ada teks di dalam search bar.
        suffixIcon: _textController.text.isEmpty
            ? null // Jika kosong, tidak ada ikon.
            : IconButton(
                icon: const Icon(Icons.clear), // Ikon 'x'
                onPressed: () {
                  // Saat ditekan:
                  _textController.clear(); // 1. Hapus teks di dalam controller.
                  _activityController.updateSearchQuery(''); // 2. Update state di ActivityController.
                  FocusScope.of(context).unfocus(); // 3. Tutup keyboard.
                },
              ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Color(0xFFBDBDBD), width: 1.5),
        ),
      ),
    );
  }
}
