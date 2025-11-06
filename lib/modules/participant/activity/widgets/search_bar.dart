import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../activity_controller.dart';

class TSearchBar extends StatelessWidget {
  const TSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ActivityController>();

    return TextFormField(
      onChanged: controller.updateSearchQuery,
      decoration: InputDecoration(
        hintText: 'Aktivitas...',
        prefixIcon: Icon(
          Icons.search,
          color: Colors.grey[500],
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
