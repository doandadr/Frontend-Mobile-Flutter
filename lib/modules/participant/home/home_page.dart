import 'package:flutter/material.dart';
import 'package:frontend_mobile_flutter/core/utils.dart';
import 'package:frontend_mobile_flutter/modules/participant/activity/widgets/app_bar.dart';
import 'package:frontend_mobile_flutter/modules/participant/home/home_controller.dart';
import 'package:get/get.dart';

import '../../../app_pages.dart';
import '../../../core/app_colors.dart';
import '../../../data/models/event/event.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: TAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            TextField(
              onChanged: (value) => controller.searchQuery.value = value,
              decoration: InputDecoration(
                hintText: "Cari nama, deskripsi, atau lokasi acara",
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
            ),
            const SizedBox(height: 16),
            Obx(() {
              final active = controller.activeFilter.value;
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ChoiceChip.elevated(
                      elevation: 1,
                      backgroundColor: const Color(0xFFEBFAFF),
                      selectedColor: Colors.blue[200],
                      label: const Text('Semua'),
                      selected: active == null,
                      onSelected: (_) {
                        // Tapping "All" clears filter
                        controller.activeFilter.value = null;
                      },
                    ),
                    const SizedBox(width: 8),
                    ChoiceChip.elevated(
                      elevation: 1,
                      backgroundColor: const Color(0xFFEBFAFF),
                      selectedColor: Colors.blue[200],
                      label: const Text('Berlangsung'),
                      selected: active == HomeFilter.active,
                      onSelected: (_) =>
                          controller.toggleFilter(HomeFilter.active),
                    ),
                    const SizedBox(width: 8),
                    ChoiceChip.elevated(
                      elevation: 1,
                      backgroundColor: const Color(0xFFEBFAFF),
                      selectedColor: Colors.blue[200],
                      label: const Text('Akan Datang'),
                      selected: active == HomeFilter.upcoming,
                      onSelected: (_) =>
                          controller.toggleFilter(HomeFilter.upcoming),
                    ),
                    const SizedBox(width: 8),
                    ChoiceChip.elevated(
                      elevation: 1,
                      backgroundColor: const Color(0xFFEBFAFF),
                      selectedColor: Colors.blue[200],
                      label: const Text('Selesai'),
                      selected: active == HomeFilter.past,
                      onSelected: (_) =>
                          controller.toggleFilter(HomeFilter.past),
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 12),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final list = controller.visibleEvents;
                if (list.isEmpty) {
                  return const Center(
                    child: Text('Belum Ada Acara'),
                  );
                }
                return RefreshIndicator(
                  onRefresh: controller.refreshEvents,
                  child: ListView.separated(
                    itemCount: list.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {

                      final Event e = list[index];
                      return _EventListTile(event: e, filterCategory: controller.getFilter(e),);
                    },
                  ),
                );

              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _EventListTile extends StatelessWidget {
  final Event event;
  final HomeFilter filterCategory;

  const _EventListTile({required this.event,required this.filterCategory});

  @override
  Widget build(BuildContext context) {
    final waktu = event.acaraMulai;
    final tanggal = Utils.fromDateTimeToIndonesiaDate(waktu);
    final jam = Utils.jamMenitSafe(waktu);
    final lokasi = event.lokasi;

    Color statusColor;
    String filterText;

    switch (filterCategory) {
      case HomeFilter.active:
        statusColor = Colors.orange.shade100;
        filterText = "Berlangsung";
        break;
      case HomeFilter.upcoming:
        statusColor = Colors.green.shade100;
        filterText = "Akan Datang";
        break;
      case HomeFilter.past:
        statusColor = Colors.red.shade100;
        filterText = "Sudah Selesai";
        break;
      case HomeFilter.none:
        filterText = "Segera Hadir";
        statusColor = Colors.grey.shade100;
        break;
    }


    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(

        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: event.mediaUrls?.banner != null
                        ? Image.network(
                      event.mediaUrls!.banner!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/placeholder-img.jpg',
                          fit: BoxFit.cover,
                        );
                      },
                    )
                        : Image.asset(
                      'assets/images/placeholder-img.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment
                        .start,
                    children: [
                      Text(
                        event.nama,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 2.0,
                        runSpacing: 2.0,
                        children: [
                          _buildEventInfo(
                            Icons.calendar_today,
                            tanggal,
                          ),
                          _buildEventInfo(
                            Icons.access_time,
                            jam,
                          ),
                          _buildEventInfo(
                            Icons.location_on,
                            (lokasi != null && lokasi.isNotEmpty)
                                ? (lokasi.length > 13 ? '${lokasi.substring(0, 10)}...' : lokasi)
                                : "Online",
                          ),
                          _buildEventInfo(
                            Icons.circle,
                            filterText,
                            backgroundColor: statusColor,
                            iconSize: 10,
                            textColor: Colors.black87,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue[500]!,
                    Colors.blue[400]!
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.DETAIL, arguments: {
                    "id":event.id,
                    "data":null
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  minimumSize: const Size.fromHeight(30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Detail Acara',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildEventInfo(
    IconData icon,
    String label, {
      Color backgroundColor = AppColors.chipBackground,
      Color textColor = Colors.black87,
      double iconSize = 16,
    }) {
  return Container(
    margin: const EdgeInsets.only(right: 4, bottom: 4),
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: iconSize, color: textColor),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 12, color: textColor)),
      ],
    ),
  );
}
