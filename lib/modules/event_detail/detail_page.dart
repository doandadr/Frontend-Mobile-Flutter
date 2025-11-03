import 'package:flutter/material.dart';
import 'package:frontend_mobile_flutter/core/app_colors.dart';
import 'package:frontend_mobile_flutter/modules/event_detail/event_detail_controller.dart';
import 'package:frontend_mobile_flutter/modules/participant/home/widgets/register_event_popup.dart';
import 'package:get/get.dart';
import 'package:frontend_mobile_flutter/modules/participant/activity/widgets/app_bar.dart';
import 'package:get_storage/get_storage.dart';

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
    final data = args["data"];
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
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EventHeroCard(
                  title: event.nama,
                  location: event.lokasi ?? 'N/A',
                  dateTimeText:
                      '${event.acara?.mulai ?? ''} - ${event.acara?.selesai ?? ''}',
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
                  isRegistered: controller.isRegistered.value,
                  description: event.deskripsi,
                  primaryColor: AppColors.primary,
                  registerButtonText:
                      controller.isUserLoggedIn.value? (controller.canRegister(event)?  "Daftar Acara" : "Batal Daftar")  : "Login Untuk Mendaftar",
                      // controller.eventDetail.value?.statusAcara != "Akan Datang"
                      // ? 'Pendaftaran Ditutup'
                      // : (controller.isUserLoggedIn.value
                      //       ? (controller.isRegistered.value
                      //             ? 'Sudah Daftar'
                      //             : 'Daftar Sekarang')
                      //       : 'Login Untuk Mendaftar'),
                  onRegister:
                      // controller.isUserLoggedIn.value &&
                      //     !controller.isRegistered.value &&
                      //     controller.eventDetail.value?.statusAcara !=
                      //         "Akan Datang"
                      // ? () {
                      //     RegisterEventPopup.show(
                      //       context,
                      //       onSubmit: (agree, offline, online) {},
                      //       eventId: controller.eventDetail.value!.id,
                      //     );
                      //   }
                      // : null,
                      controller.isUserLoggedIn.value? (controller.canRegister(event)? (){
                        RegisterEventPopup.show(
                                context,
                                onSubmit: (agree, offline, online) {},
                                eventId: controller.eventDetail.value!.id,
                              );
                      } : (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Konfirmasi"),
                              content: const Text("Anda yakin membatalkan acara ini?"),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text("Tidak"),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                                TextButton(
                                  child: const Text("Ya"),
                                  onPressed: () {
                                    // TODO: call controller to cancel registration
                                    Get.back();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }) : null,

                  shareUrl:
                      'https://airnav-event.vercel.app/user/event/${event.id}',
                ),
                const SizedBox(height: 16),
                controller.isRegistered.value
                    ? SectionTileCard(
                        leadingIcon: Icons.description_outlined,
                        iconColor: AppColors.primary,
                        title: 'Susunan Acara',
                        trailing: IconButton(
                          onPressed:(){
                                    if (data.modulAcara?.mdlFileRundownUrl != null){
                                      Get.snackbar('Susunan Acara', data.modulAcara!.mdlFileRundownUrl!);
                                      Utils.openUrl(data.modulAcara!.mdlFileRundownUrl!);
                                    }
                          },
                          icon: const Icon(Icons.download_rounded),
                          color: AppColors.primary,
                        ),
                        onTap: () {},
                      )
                    : const SizedBox.shrink(),
                const SizedBox(height: 10),
                controller.isRegistered.value
                    ? SectionTileCard(
                        leadingIcon: Icons.menu_book_outlined,
                        iconColor: AppColors.primary,
                        title: 'Modul Acara',
                        trailing: IconButton(
                          onPressed:(){
                            if (data.modulAcara?.mdlFileAcaraUrl != null){
                              Get.snackbar('Modul Acara', data.modulAcara!.mdlFileAcaraUrl!);
                              Utils.openUrl(data.modulAcara!.mdlFileAcaraUrl!);
                            }
                          },
                          icon: const Icon(Icons.download_rounded),
                          color: AppColors.primary,
                        ),
                        onTap: () {},
                      )
                    : const SizedBox.shrink(),
                const SizedBox(height: 16),
                InfoListCard(
                  title: 'Informasi Acara',
                  items: [
                    InfoItem(label: 'Alamat', value: event.lokasi ?? 'N/A'),
                    InfoItem(
                      label: 'Pendaftaran',
                      value:
                          '${event.pendaftaran?.mulai ?? ''} - ${event.pendaftaran?.selesai ?? ''}',
                    ),
                    InfoItem(
                      label: 'Jam Acara',
                      value:
                          '${event.acara?.mulaiRaw ?? ''} - ${event.acara?.selesaiRaw ?? ''}',
                    ),
                    InfoItem(
                      label: 'Tanggal Acara',
                      value: event.acara?.mulai ?? '',
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (event.catatan != null && event.catatan!.isNotEmpty)
                  AdditionalInfoCard(
                    title: 'Informasi Tambahan',
                    contentLines: event.catatan!.split(''),
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
