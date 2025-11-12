import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:frontend_mobile_flutter/modules/participant/activity/activity_controller.dart';
import 'package:frontend_mobile_flutter/modules/participant/activity/widgets/activity_container.dart';
import 'package:frontend_mobile_flutter/modules/participant/activity/widgets/app_bar.dart';
import 'package:frontend_mobile_flutter/modules/participant/activity/widgets/search_bar.dart';
import 'package:frontend_mobile_flutter/modules/participant/profile/widgets/call_to_login.dart';

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
          // Belum login -> ajak login
          if (!controller.isLoggedIn.value) {
            return const CallToLogin(page: "acara");
          }

          // Loading awal
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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 1),

              // Area list + pull-to-refresh
              Expanded(
                child: RefreshIndicator(
                  onRefresh: controller.refreshFollowed, // Future<void> expected
                  child: items.isEmpty
                  // ====== STATE KOSONG: tetap scrollable agar RefreshIndicator mau jalan ======
                      ? LayoutBuilder(
                    builder: (context, constraints) {
                      return ListView(
                        physics:
                        const AlwaysScrollableScrollPhysics(), // penting
                        children: [
                          SizedBox(
                            height: constraints.maxHeight,
                            child: const Center(
                              child: Text('Belum ada aktivitas'),
                            ),
                          ),
                        ],
                      );
                    },
                  )
                  // ====== STATE ADA DATA ======
                      : ListView.separated(
                    physics:
                    const AlwaysScrollableScrollPhysics(), // tetap bisa tarik refresh walau item sedikit
                    itemCount: items.length,
                    separatorBuilder: (_, _) =>
                    const SizedBox(height: 8),
                    itemBuilder: (_, i) {
                      final d = items[i];
                      final name = controller.eventNameOf(d);
                      final date = controller
                          .formatDate(controller.eventDateOf(d));
                      final status = controller.eventStatus(d);

                      if (status == 'Unknown') {
                        return const SizedBox.shrink();
                      }
                      
                      bool isPresent = false;//d.presensi != null && d.presensi?.status == "Hadir";

                      return ActivityContainer(
                        eventName: name,
                        eventDate: date,
                        status: status,
                        isPresent: isPresent,
                        urlSertifikat:d.certificateUrl,
                        hasDoorprize: d.hasDoorprize == 1,
                        onTap: () async {
                          await Get.toNamed(
                            Routes.DETAIL,
                            arguments: {
                              "id": d.modulAcaraId,
                              "data": d,
                            },
                          );
                          // refresh setelah kembali dari detail
                          await controller.refreshFollowed();
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
