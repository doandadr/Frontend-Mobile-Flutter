// lib/modules/main/views/main_view.dart
import 'package:flutter/material.dart';
import 'package:frontend_mobile_flutter/modules/auth/auth_page.dart';
import 'package:frontend_mobile_flutter/modules/main_container/main_controller.dart';
import 'package:frontend_mobile_flutter/modules/participant/activity/activity_page.dart';
import 'package:frontend_mobile_flutter/modules/event_detail/detail_page.dart';
import 'package:frontend_mobile_flutter/modules/participant/activity/scan/scan_page.dart';
import 'package:frontend_mobile_flutter/modules/participant/home/home_page.dart';
import 'package:frontend_mobile_flutter/modules/participant/profile/profile_page.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:frontend_mobile_flutter/modules/participant/notification/notification_page.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  List<Widget> _screens() => const [
    HomePage(),
    ActivityPage(),
    ScanPage(),
    ProfilePage(),
  ];

  List<PersistentBottomNavBarItem> _items() => [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.home_outlined),
      title: 'Dashboard',
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.assignment_outlined),
      title: 'Aktivitas',
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.qr_code_scanner),
      title: 'Presensi',
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.person_outline),
      title: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: controller.tabController,
      screens: _screens(),
      items: _items(),
      navBarStyle: NavBarStyle.style3,
      backgroundColor: Colors.white,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(12),
        colorBehindNavBar: Colors.white,
      ),
      stateManagement: false, // GetX yang handle state
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
    );
  }
}
