import 'package:flutter/material.dart';
import 'package:frontend_mobile_flutter/modules/participant/activity/activity_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app_pages.dart';
import '../../../../core/utils.dart';

class ActivityContainer extends StatelessWidget {
  final String eventName;
  final String eventDate;
  final ActivityFilter status;
  final VoidCallback? onTap;
  final bool isPresent;
  final String? urlSertifikat;
  final bool? hasDoorprize;

  const ActivityContainer({
    super.key,
    required this.eventName,
    required this.eventDate,
    required this.status,
    this.onTap,
    required this.isPresent,
    this.urlSertifikat,
    this.hasDoorprize,
  });

  @override
  Widget build(BuildContext context) {
    const borderBlue = Color(0xFF9ED1F5);
    const headerBlue = Color(0xFFDDF3FF);
    const darkBlue = Color(0xFF10498D);
    const yellow50 = Color(0xFFFEFCE8);
    const yellow900 = Color(0xFF713F12);

    final String chipText;
    final String btnText;
    final IconData btnIcon;
    final Color statusBgColor;
    final Color statusTextColor;
    final Color dotColor;
    final Color buttonBgColor;
    final Color buttonFgColor;

    switch (status) {
      case ActivityFilter.mendatang:
        chipText = 'Belum Mulai';
        btnText = 'Menunggu';
        btnIcon = Icons.access_time;
        statusBgColor = const Color(0xFFFFF6E0);
        statusTextColor = const Color(0xFFD79A00);
        dotColor = const Color(0xFF9AA3AF);
        buttonBgColor = const Color(0xFFD1D5DB);
        buttonFgColor = Colors.black;
        break;
      case ActivityFilter.berlangsung:
        chipText = 'Berlangsung';
        btnText = isPresent ? 'Hadir' : 'Belum Absen';
        btnIcon = isPresent
            ? Icons.check_circle_outline_outlined
            : Icons.qr_code_scanner;
        statusBgColor = const Color(0xFFEFFFF9);
        statusTextColor = const Color(0xFF049E67);
        dotColor = const Color(0xFF02C26A);
        buttonBgColor = const Color(0xFF175FA4);
        buttonFgColor = Colors.white;
        break;
      case ActivityFilter.selesai:
        chipText = 'Selesai';
        btnText = (isPresent && urlSertifikat != null)
            ? 'Sertifikat'
            : 'Ditutup';
        btnIcon = isPresent ? Icons.download : Icons.cancel_outlined;
        statusBgColor = const Color(0xFFFFF6E0);
        statusTextColor = const Color(0xFFD79A00);
        dotColor = const Color(0xFF9AA3AF);
        buttonBgColor = const Color(0xFFD1D5DB);
        buttonFgColor = Colors.black;
        break;
    }

    VoidCallback? onActionTapHandler;
    if (status == ActivityFilter.berlangsung) {
      onActionTapHandler = () {
        if (isPresent) {
          Get.snackbar(
            'Sudah absen',
            'Anda sudah melakukan absensi untuk event ini',
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar('Scan QR Code', 'Scan untuk absensi kegiatan.');
          Get.toNamed(Routes.SCAN);
        }
      };
    } else if (status == ActivityFilter.selesai) {
      if (isPresent && urlSertifikat != null) {
        onActionTapHandler = () {
            Utils.openUrl(urlSertifikat);
        };
      } else {
        onActionTapHandler = null; // Disabled for 'Ditutup'
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: borderBlue, width: 1.5),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ===== Header biru =====
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: headerBlue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          eventName,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: darkBlue,
                          ),
                          softWrap: true,
                          maxLines: null,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        eventDate,
                        textAlign: TextAlign.right,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: darkBlue,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const Text(
                        //   'Status :',
                        //   style: TextStyle(
                        //     fontSize: 14,
                        //     fontWeight: FontWeight.w600,
                        //     color: Color(0xFF7A869A),
                        //   ),
                        // ),
                        // const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: statusBgColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            chipText,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: statusTextColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if (hasDoorprize == true)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: yellow50,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            hasDoorprize == true ? "Pemenang Doorprize" : "",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: yellow900,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Bulatan dan Tombol
                    Row(
                      children: [
                        if (status != ActivityFilter.mendatang) ...[
                          // Container(
                          //   width: 10,
                          //   height: 10,
                          //   decoration: BoxDecoration(
                          //     shape: BoxShape.circle,
                          //     color: dotColor,
                          //   ),
                          // ),
                          // const SizedBox(width: 8),
                          // Kemudian tombol ditampilkan
                          TextButton.icon(
                            onPressed: onActionTapHandler,
                            icon: Icon(btnIcon, color: buttonFgColor),
                            label: Text(
                              btnText,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                color: buttonFgColor,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: buttonBgColor,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 28,
                                vertical: 10,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
