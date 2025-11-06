import 'package:flutter/material.dart';
import 'package:frontend_mobile_flutter/modules/participant/profile/widgets/call_to_login.dart';
import 'package:get/get.dart';

import 'package:frontend_mobile_flutter/modules/participant/activity/activity_controller.dart';
import 'package:frontend_mobile_flutter/modules/participant/activity/widgets/activity_container.dart';
import 'package:frontend_mobile_flutter/modules/participant/activity/widgets/app_bar.dart';
import 'package:frontend_mobile_flutter/modules/participant/activity/widgets/search_bar.dart';

import '../../../app_pages.dart';

class ActivityPage extends GetView<ActivityController> {
  const ActivityPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Obx(() {
          if (!controller.isLoggedIn.value) {
            return CallToLogin(page: "acara");
          }

          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          final items = controller.filteredFollowed;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TSearchBar(),
              const SizedBox(height: 10),
              const Text(
                'Aktivitas',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: controller.refreshFollowed,
                  child: items.isEmpty
                      ? const Center(child: Text('Belum ada aktivitas'))
                      : ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: items.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 8),
                          itemBuilder: (_, i) {
                            final d = items[i];
                            final name = controller.eventNameOf(d);
                            final date = controller.formatDate(
                              controller.eventDateOf(d),
                            );
                            final status = controller.eventStatus(d);
                            if (status == 'Unknown') {
                              return const SizedBox.shrink();
                            }

                            return ActivityContainer(
                              eventName: name,
                              eventDate: date,
                              status: status,
                              onTap: () async {
                                await Get.toNamed(
                                  Routes.DETAIL,
                                  arguments: {
                                    "id" : d.modulAcaraId,
                                    "data" : d,
                                  },
                                );
                                controller.refreshFollowed();
                              },
                              onActionTap: () {
                                if (status == ActivityFilter.selesai) {
                                  Get.snackbar(
                                    'Sertifikat',
                                    'Fitur Unduh sertifikat akan segera hadir.',
                                  );
                                } else if (status == ActivityFilter.berlangsung) {
                                  Get.snackbar(
                                    'Scan QR Code',
                                    'Scan untuk absensi kegiatan.',
                                  );
                                  Get.toNamed(Routes.SCAN);
                                }
                              },
                            );
                          },
                        ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
