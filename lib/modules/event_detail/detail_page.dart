import 'package:flutter/material.dart';
import 'package:frontend_mobile_flutter/core/app_colors.dart';
import 'package:frontend_mobile_flutter/modules/event_detail/event_detail_controller.dart';
import 'package:frontend_mobile_flutter/modules/participant/home/widgets/fail_register.dart';
import 'package:frontend_mobile_flutter/modules/participant/home/widgets/register_event_popup.dart';
import 'package:frontend_mobile_flutter/modules/participant/home/widgets/success_register.dart';
import 'package:get/get.dart';
import 'package:frontend_mobile_flutter/modules/participant/activity/widgets/app_bar.dart';

import '../../core/utils.dart';
import '../../data/models/event/followed_event.dart';
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

          final DateTime registrationStartDate = event.pendaftaran.mulaiRaw;
          final DateTime registrationEndDate = event.pendaftaran.selesaiRaw;
          final DateTime eventStartDate =event.acara.mulaiRaw;
          final DateTime eventEndDate =event.acara.selesaiRaw ?? eventStartDate.add(const Duration(days: 1));

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EventHeroCard(
                  title: event.nama,
                  location: event.lokasi ?? 'N/A',
                  dateTimeText:
                  '${event.acara.mulai ?? ''} - ${event.acara.selesai ?? ''}',
                  imageUrl: event.banner,
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
                  shareUrl: 'https://airnav-event.vercel.app/user/event/${event.id}',

                  isLoggedIn: controller.isUserLoggedIn.value,
                  isRegistered: controller.isRegistered.value,
                  registrationStartDate: registrationStartDate,
                  registrationEndDate: registrationEndDate,
                  eventStartDate: eventStartDate,
                  eventEndDate: eventEndDate,
                  isAttendanceActive: event.presensiAktif,
                  
                  onLogin: controller.goToLogin,
                  onRegister: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Daftar Acara'),
                        content: const Text('Apakah Anda ingin mendaftar acara ini?'),
                        actions: [
                          TextButton(
                            onPressed: () => Get.back(),
                            child: const Text('Tidak'),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                            onPressed: () async {
                              Get.back();
                              final errorMessage = await controller.register(eventId);
                              if (errorMessage == null) {
                                SuccessRegister.show(context, title: 'SUCCESS', subtitle: 'Pendaftaran Berhasil');
                              } else {
                                FailRegister.show(context, title: 'FAILED', subtitle: errorMessage);
                              }
                            },
                            child: const Text('Daftar', style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    );
                  },
                  onCancelRegistration: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Batal Pendaftaran'),
                        content: const Text('Apakah Anda yakin ingin membatalkan pendaftaran acara ini?'),
                        actions: [
                          TextButton(
                            onPressed: () => Get.back(),
                            child: const Text('Tidak'),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                            onPressed: () async {
                              Get.back();
                              final errorMessage = await controller.cancelRegistration(eventId);
                              if (errorMessage == null) {
                                SuccessRegister.show(context, title: 'SUCCESS', subtitle: 'Pembatalan Berhasil');
                              } else {
                                FailRegister.show(context, title: 'FAILED', subtitle: errorMessage);
                              }
                            },
                            child: const Text('Batalkan', style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    );
                  },
                  onScan: controller.scanQrCode,
                ),
                const SizedBox(height: 16),
                if(controller.isRegistered.value) ...[
                   SectionTileCard(
                    leadingIcon: Icons.description_outlined,
                    iconColor: AppColors.primary,
                    title: 'Susunan Acara',
                    trailing: IconButton(
                      onPressed:(){
                        if (event.fileRundown != null){
                          Utils.openUrl(event.fileRundown);
                        }
                      },
                      icon: const Icon(Icons.download_rounded),
                      color: AppColors.primary,
                    ),
                    onTap: () {},
                  ),
                  const SizedBox(height: 10),
                  SectionTileCard(
                    leadingIcon: Icons.menu_book_outlined,
                    iconColor: AppColors.primary,
                    title: 'Modul Acara',
                    trailing: IconButton(
                      onPressed:(){
                         if (event.fileAcara != null){
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
                    InfoItem(label: 'Alamat', value: event.lokasi ?? 'N/A'),
                    InfoItem(
                      label: 'Pendaftaran',
                      value:
                      '${event.pendaftaran.mulai ?? ''} - ${event.pendaftaran.selesai ?? ''}',
                    ),
                    InfoItem(
                      label: 'Jam Acara',
                      value:
                      '${event.acara.mulai ?? ''} - ${event.acara.selesai ?? ''}',
                    ),
                    InfoItem(
                      label: 'Tanggal Acara',
                      value: event.acara.mulai,
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