import 'package:flutter/material.dart';
import 'package:frontend_mobile_flutter/core/app_colors.dart';
import 'package:frontend_mobile_flutter/modules/event_detail/event_detail_controller.dart';
import 'package:frontend_mobile_flutter/modules/participant/home/widgets/fail_register.dart';
import 'package:frontend_mobile_flutter/modules/participant/home/widgets/new_register_event_popup.dart';
import 'package:frontend_mobile_flutter/modules/participant/home/widgets/success_register.dart';
import 'package:get/get.dart';
import 'package:frontend_mobile_flutter/modules/participant/activity/widgets/app_bar.dart';
import 'package:intl/intl.dart';

import '../../core/utils.dart';
import '../participant/home/widgets/event_hero_card.dart';
import '../participant/home/widgets/about_event_card.dart';
import '../participant/home/widgets/section_tile_card.dart';
import '../participant/home/widgets/info_list_card.dart';
import '../participant/home/widgets/additional_info_card.dart';

class DetailPage extends GetView<EventDetailController> {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map;
    final eventId = args["id"];
    final data = args["data"]; // Keep for existing logic if needed

    controller.loadEventDetail(eventId);
    if (controller.isUserLoggedIn.value) {
      controller.loadRegistration(eventId);
    }

    return Scaffold(
      appBar: TAppBar(),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.hasError) {
          return Center(child: Text(controller.errorMessage.value));
        }

        if (controller.hasData) {
          final event = controller.eventDetail.value!;

          String eventRegStartShort = DateFormat(
            "d MMM yyy",
            "id_ID",
          ).format(event.pendaftaranMulai);
          String eventRegEndShort = DateFormat(
            "d MMM yyy",
            "id_ID",
          ).format(event.pendaftaranMulai);
          String eventStartShort = DateFormat(
            "d MMM yyy",
            "id_ID",
          ).format(event.pendaftaranMulai);
          String eventRegStartHour = DateFormat(
            "HH:mm",
            "id_ID",
          ).format(event.pendaftaranMulai);
          String eventRegEndHour = DateFormat(
            "HH:mm",
            "id_ID",
          ).format(event.pendaftaranSelesai);
          String eventStartHour = DateFormat(
            "HH:mm",
            "id_ID",
          ).format(event.acaraMulai);
          String eventEndHour = event.acaraSelesai != null
              ? DateFormat("HH:mm", "id_ID").format(event.acaraSelesai!)
              : '';
          String eventStartFull = DateFormat(
            "d MMMM yyy",
            "id_ID",
          ).format(event.acaraMulai);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EventHeroCard(
                  title: event.nama,
                  location: event.lokasi ?? 'N/A',
                  dateTimeText:
                      '$eventStartFull, $eventStartHour${event.acaraSelesai != null ? ' - $eventEndHour' : ''}',
                  imageUrl: event.bannerAcara,
                  borderColor: AppColors.primary,
                ),
                const SizedBox(height: 20),
                AboutEventCard(
                  titleWidget: RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.titleLarge,
                      children: const [TextSpan(text: 'Tentang Acara')],
                    ),
                  ),
                  description: event.deskripsi,
                  primaryColor: AppColors.primary,
                  shareUrl:
                      'https://airnav-event.vercel.app/user/event/${event.id}',

                  isLoggedIn: controller.isUserLoggedIn.value,
                  isRegistered: controller.isRegistered.value,
                  registrationStartDate: event.pendaftaranMulai,
                  registrationEndDate: event.pendaftaranSelesai,
                  eventStartDate: event.acaraMulai,
                  eventEndDate:
                      event.acaraSelesai ??
                      event.acaraMulai.add(const Duration(days: 1)),
                  isAttendanceActive: event.presensiAktif,

                  onLogin: controller.goToLogin,
                  onRegister: () {
                        Get.dialog(AttendanceDialog(eventId: eventId));
                  },
                  onCancelRegistration: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Batal Pendaftaran'),
                        content: const Text(
                          'Apakah Anda yakin ingin membatalkan pendaftaran acara ini?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Get.back(),
                            child: const Text('Tidak'),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            onPressed: () async {
                              Get.back();
                              final errorMessage = await controller
                                  .cancelRegistration(eventId);
                              if (errorMessage == null) {
                                SuccessRegister.show(
                                  context,
                                  title: 'SUCCESS',
                                  subtitle: 'Pembatalan Berhasil',
                                );
                              } else {
                                FailRegister.show(
                                  context,
                                  title: 'FAILED',
                                  subtitle: errorMessage,
                                );
                              }
                            },
                            child: const Text(
                              'Batalkan',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  onScan: controller.scanQrCode,
                ),
                const SizedBox(height: 16),
                if (controller.isRegistered.value) ...[
                  if (event.fileRundown != null) SectionTileCard(
                    leadingIcon: Icons.description_outlined,
                    iconColor: AppColors.primary,
                    title: 'Susunan Acara',
                    trailing: IconButton(
                      onPressed: () {
                        if (event.fileRundown != null) {
                          Utils.openUrl(event.fileRundown);
                        }
                      },
                      icon: const Icon(Icons.download_rounded),
                      color: AppColors.primary,
                    ),
                    onTap: () {},
                  ),
                  const SizedBox(height: 10),
                  if (event.fileAcara != null) SectionTileCard(
                    leadingIcon: Icons.menu_book_outlined,
                    iconColor: AppColors.primary,
                    title: 'Modul Acara',
                    trailing: IconButton(
                      onPressed: () {
                        if (event.fileAcara != null) {
                          Utils.openUrl(event.fileAcara);
                        }
                      },
                      icon: const Icon(Icons.download_rounded),
                      color: AppColors.primary,
                    ),
                    onTap: () {},
                  ),
                  const SizedBox(height: 16),
                ],
                InfoListCard(
                  title: 'Informasi Acara',
                  items: [
                    InfoItem(
                      leading: const Icon(
                        Icons.location_on_outlined,
                        size: 20,
                      ),
                      label: 'Lokasi',
                      value: event.lokasi ?? 'N/A',
                    ),
                    InfoItem(
                      leading: const Icon(
                        Icons.how_to_reg_outlined,
                        size: 20,
                      ),
                      label: 'Pendaftaran',
                      value:
                          '$eventRegStartShort $eventRegStartHour - $eventRegEndShort $eventRegEndHour',
                    ),
                    InfoItem(
                      leading: const Icon(
                        Icons.calendar_today_rounded,
                        size: 20,
                      ),
                      label: 'Tanggal Acara',
                      value: eventStartShort,
                    ),
                    InfoItem(
                      leading: const Icon(
                        Icons.access_time_rounded,
                        size: 20,
                      ),
                      label: 'Jam Acara',
                      value:
                          eventStartHour +
                          (event.acaraSelesai != null
                              ? ' - $eventEndHour'
                              : ''),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (event.catatan != null && event.catatan!.isNotEmpty)
                  AdditionalInfoCard(
                    title: 'Informasi Tambahan',
                    contentLines: event.catatan!.split('\n'),
                  ),
              ],
            ),
          );
        }

        return const Center(child: Text('No event data available.'));
      }),
    );
  }
}
