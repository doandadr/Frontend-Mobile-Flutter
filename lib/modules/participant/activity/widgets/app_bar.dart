// import 'package:flutter/material.dart';
// import 'package:frontend_mobile_flutter/modules/participant/activity/widgets/notification_button.dart';
// import 'package:get/get.dart';

// class TAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const TAppBar({super.key});

//   @override
//   Size get preferredSize =>
//       const Size.fromHeight(kToolbarHeight); // 👈 required

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       title: Row(
//         children: [
//           Image.asset(
//             'assets/logo.png',
//             height: 35,
//           ),
//           const SizedBox(width: 8),
//           const Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Aktivitas Saya', style: TextStyle(fontSize: 16)),
//               Text('AirNav Indonesia', style: TextStyle(fontSize: 12)),
//             ],
//           ),
//           const Spacer(),
//           NotificationButton(
//             notificationCount: 5,
//             onPressed: () {
//               Get.snackbar(
//                   'Notification', 'You tapped on the notification button');
//             },
//           ),
//           const CircleAvatar(
//             backgroundImage: AssetImage('assets/logo.png'),
//             radius: 20,
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:frontend_mobile_flutter/core/app_colors.dart';
import 'package:frontend_mobile_flutter/modules/participant/profile/profile_controller.dart';
import 'package:get/get.dart';

class TAppBar extends GetView<ProfileController> implements PreferredSizeWidget {
  const TAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 35, // TODO extract to constants
            height: 35,
            child: Image(
              image: AssetImage('assets/images/appbar_logo_airnav.png'),
            ),
          ),
          const SizedBox(width: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Event Management',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'AirNav Indonesia',
                style: TextStyle(
                  color: Colors.grey[700], // TODO use style color
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        // NotificationButton(
        //   notificationCount: 1,
        //   onPressed: () => {},
        // ),
        // const SizedBox(width: 8.0),
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Obx(() {
            ImageProvider? backgroundImage;
            if (controller.profileImageFile.value != null) {
              backgroundImage = FileImage(controller.profileImageFile.value!);
            } else if (controller.profileImageUrl.value.isNotEmpty) {
              backgroundImage = NetworkImage(controller.profileImageUrl.value);
            } else {
              backgroundImage = const AssetImage("assets/images/user_image.jpg");
            }
            return CircleAvatar(
              radius: 18,
              backgroundImage: backgroundImage,
            );
          }),
        ),
      ],
      backgroundColor: Colors.white,
      elevation: 1,
      scrolledUnderElevation: 0,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
