import 'package:flutter/material.dart';
import 'package:frontend_mobile_flutter/modules/participant/activity/widgets/app_bar.dart';
import 'package:frontend_mobile_flutter/modules/participant/home/home_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final active = controller.activeFilter.value;
          final list = controller.visibleEvents;

          return Column(
            children: [
              const SizedBox(height: 16),
              // Mengganti TextField dengan widget stateful baru
              const _HomePageSearchBar(),
              const SizedBox(height: 5),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildFilterChip(
                      label: 'Semua',
                      isSelected: active == null,
                      onSelected: (_) => controller.activeFilter.value = null,
                    ),
                    const SizedBox(width: 4),
                    _buildFilterChip(
                      label: 'Segera Hadir',
                      isSelected: active == HomeFilter.upcoming,
                      onSelected: (_) =>
                          controller.toggleFilter(HomeFilter.upcoming),
                    ),
                    const SizedBox(width: 4),
                    _buildFilterChip(
                      label: 'Pendaftaran Dibuka',
                      isSelected: active == HomeFilter.open,
                      onSelected: (_) =>
                          controller.toggleFilter(HomeFilter.open),
                    ),
                    const SizedBox(width: 4),
                    _buildFilterChip(
                      label: 'Pendaftaran Ditutup',
                      isSelected: active == HomeFilter.closed,
                      onSelected: (_) =>
                          controller.toggleFilter(HomeFilter.closed),
                    ),
                    const SizedBox(width: 4),
                    _buildFilterChip(
                      label: 'Berlangsung',
                      isSelected: active == HomeFilter.active,
                      onSelected: (_) =>
                          controller.toggleFilter(HomeFilter.active),
                    ),
                    const SizedBox(width: 4),
                    _buildFilterChip(
                      label: 'Selesai',
                      isSelected: active == HomeFilter.past,
                      onSelected: (_) =>
                          controller.toggleFilter(HomeFilter.past),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: controller.refreshEvents,
                  child: list.isEmpty
                      ? LayoutBuilder(
                          builder: (context, constraints) {
                            return ListView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              children: [
                                SizedBox(
                                  height: constraints.maxHeight,
                                  child: const Center(
                                    child: Text('Belum ada acara'),
                                  ),
                                ),
                              ],
                            );
                          },
                        )
                      : ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: list.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            final Event e = list[index];
                            return _EventListTile(
                              event: e,
                              filterCategory: controller.getFilter(e),
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

  // Widget private untuk membuat chip filter dengan gaya yang konsisten.
  Widget _buildFilterChip({
    required String label,
    required bool isSelected,
    required ValueChanged<bool> onSelected,
  }) {
    return ChoiceChip(
      label: FittedBox(fit: BoxFit.scaleDown,child: Text(label),),
      clipBehavior: Clip.none,
      selected: isSelected,
      onSelected: onSelected,
      labelStyle: GoogleFonts.poppins(
        color: isSelected ? Colors.white : Colors.black54,
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
      backgroundColor: Colors.white,
      selectedColor: const Color(0xFF175FA4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected ? const Color(0xFF175FA4) : const Color(0xFFE0E0E0),
          width: 2,
        ),
      ),
      showCheckmark: false,
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
    );
  }
}

// Widget stateful baru untuk SearchBar di halaman utama.
class _HomePageSearchBar extends StatefulWidget {
  const _HomePageSearchBar();

  @override
  State<_HomePageSearchBar> createState() => _HomePageSearchBarState();
}

class _HomePageSearchBarState extends State<_HomePageSearchBar> {
  final _textController = TextEditingController();
  final _homeController = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
      onChanged: (value) => _homeController.searchQuery.value = value,
      decoration: InputDecoration(
        hintText: "Cari nama, deskripsi, atau lokasi acara",
        prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
        suffixIcon: _textController.text.isEmpty
            ? null
            : IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _textController.clear();
                  _homeController.searchQuery.value = '';
                  FocusScope.of(context).unfocus();
                },
              ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Color(0xFFE0E0E0),
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Color(0xFFE0E0E0),
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Color(0xFFBDBDBD),
            width: 1.5,
          ),
        ),
      ),
    );
  }
}


class _EventListTile extends StatelessWidget {
  final Event event;
  final HomeFilter filterCategory;

  const _EventListTile({required this.event, required this.filterCategory});

  @override
  Widget build(BuildContext context) {
    final waktu = event.acaraMulai;
    final tanggal = DateFormat("d MMM yyyy", "id_ID").format(waktu);
    final jam = DateFormat("HH:mm", "id_ID").format(waktu);
    final lokasi = event.lokasi;

    Color statusColor;
    Color textColor;
    String filterText;

    switch (filterCategory) {
      case HomeFilter.upcoming:
        statusColor = const Color(0xFFFFF8E1);
        textColor = const Color(0xFFE67E22);
        filterText = "Segera Hadir";
        break;
      case HomeFilter.open:
        statusColor = const Color(0xFFFFEBEE);
        textColor = const Color(0xFF0F8ED4);
        filterText = "Pendaftaran Dibuka";
        break;
      case HomeFilter.closed:
        statusColor = const Color(0xFFFFEBEE);
        textColor = const Color(0xFF707070);
        filterText = "Pendaftaran Ditutup";
        break;
      case HomeFilter.active:
        statusColor = const Color(0xFFE8F5E9);
        textColor = const Color(0xFF2E7D32);
        filterText = "Berlangsung";
        break;
      case HomeFilter.past:
        statusColor = const Color(0xFFFFEBEE);
        textColor = const Color(0xFFC62828);
        filterText = "Selesai";
        break;
      default:
        statusColor = Colors.grey.shade200;
        textColor = Colors.grey.shade800;
        filterText = "N/A";
        break;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                  height: MediaQuery
                      .of(context)
                      .size
                      .width * 0.23,
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
                          _buildEventInfo(Icons.calendar_today, tanggal),
                          _buildEventInfo(Icons.access_time, jam),
                          _buildEventInfo(
                            Icons.location_on,
                            (lokasi != null &&
                                    lokasi.isNotEmpty &&
                                    event.tipe != "online")
                                ? (lokasi.length > 13
                                      ? '${lokasi.substring(0, 10)}...'
                                      : lokasi)
                                : "Online",
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 4, bottom: 4),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 4.0,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              filterText,
                              style: TextStyle(
                                fontSize: 12,
                                color: textColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue[800]!,
                    Colors.blue[400]!
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(16),
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
                  padding: const EdgeInsets.symmetric(vertical: 1),
                  shadowColor: Colors.transparent,
                  minimumSize: const Size.fromHeight(5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
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
            Text(label, style: TextStyle(fontSize: 12, color: textColor,)),
          ]));
}
