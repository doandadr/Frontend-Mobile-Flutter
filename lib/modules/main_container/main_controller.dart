// lib/modules/main/controllers/main_controller.dart
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class MainController extends GetxController {
  late final PersistentTabController tabController;
  final currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = PersistentTabController(initialIndex: 0);
    tabController.addListener(() {
      currentIndex.value = tabController.index;
    });
  }

  void switchTo(int index) => tabController.index = index;

}
