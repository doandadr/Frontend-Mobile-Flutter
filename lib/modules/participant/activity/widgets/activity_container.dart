import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    print("urlSertifikat : $urlSertifikat");
    const borderBlue = Color(0xFF9ED1F5);
    const headerBlue = Color(0xFFDDF3FF);
    const darkBlue = Color(0xFF10498D);
    const yellow50 = Color(0xFFFEFCE8);
    const yellow900 = Color(0xFF713F12);

    // ===== Chip Text berdasarkan status =====
    late final String chipText;
    late final Color chipBgColor;
    late final Color chipTextColor;

    switch (status) {
      case ActivityFilter.mendatang:
        chipText = 'Belum Dimulai';
        chipBgColor = const Color(0xFFCFEEFA);
        chipTextColor = const Color(0xFF041B4E);
        break;
      case ActivityFilter.berlangsung:
        chipText = 'Berlangsung';
        chipBgColor = const Color(0xFFA7F3D0);
        chipTextColor = const Color(0xFF065F46);
        break;
      case ActivityFilter.selesai:
        chipText = 'Acara Selesai';
        chipBgColor = const Color(0xFFFEE2E2);
        chipTextColor = const Color(0xFFDC2626);
        break;
    }

    // ===== Tombol Sertifikat (Logika tidak berubah) =====
    const String btnText = 'Sertifikat';
    const IconData btnIcon = Icons.download;

    final bool isEnabled = isPresent && urlSertifikat != null;

    final Color buttonBgColor = isEnabled
        ? const Color(0xFF175FA4)
        : const Color(0xFFCFEEFA);
    final Color buttonFgColor = isEnabled ? Colors.white : Colors.white;

    VoidCallback? onActionTapHandler;
    if (isEnabled) {
      onActionTapHandler = () {
        Utils.openUrl(urlSertifikat);
      };
    } else {
      onActionTapHandler = null;
    }

    Widget sertifikatButton = TextButton.icon(
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
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
      ),
    );

    if (!isEnabled) {
      sertifikatButton = GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {},
        child: sertifikatButton,
      );
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
                const SizedBox(height: 7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // === PERUBAHAN DI SINI ===
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Status:",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: chipBgColor,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                chipText,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: chipTextColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (hasDoorprize == true)
                          Container(
                            margin: const EdgeInsets.only(top: 6),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: yellow50,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              "Pemenang Doorprize",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: yellow900,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 7),
                StatefulBuilder(
                  builder: (context, setState) {
                    final List<bool> _selected = [true, true, false];

                    Widget _buildPill(int index, String label) {
                      final bool active = _selected[index];
                      final borderColor = active ? const Color(0xFF14C27A) : Colors.grey.shade200;
                      final bgColor = active ? const Color(0xFFECFDF5) : Colors.grey.shade50;
                      final textColor = active ? const Color(0xFF0B6B3B) : Colors.grey.shade600;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selected[index] = !_selected[index];
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 10,
                          ),
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            color: bgColor,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: borderColor, width: 3),
                          ),
                          child: Text(
                            label,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: textColor,
                            ),
                          ),
                        ),
                      );
                    }

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildPill(0, 'Hari 1'),
                          _buildPill(1, 'Hari 2'),
                          _buildPill(2, 'Hari 3'),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: 5),

                Row(
                  children: [
                    // Tombol WhatsApp Baru
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () { /* TODO: Implement WhatsApp functionality */ },
                        icon: const Icon(FontAwesomeIcons.whatsapp, color: Colors.white, size: 20),
                        label: Text("WhatsApp", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF25D366),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
                          elevation: 0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: sertifikatButton,
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
