import 'package:flutter/material.dart';
import 'package:frontend_mobile_flutter/modules/participant/activity/activity_controller.dart';

class ActivityContainer extends StatelessWidget {
  final String eventName;
  final String eventDate;
  final ActivityFilter status;
  final VoidCallback? onTap;
  final VoidCallback? onActionTap;

  const ActivityContainer({
    super.key,
    required this.eventName,
    required this.eventDate,
    required this.status,
    this.onTap,
    this.onActionTap,
  });

  // bool get _isSelesai => status == ActivityFilter.selesai;
  bool get _isBerlangsung => status == ActivityFilter.berlangsung;

  String statusMap(ActivityFilter status) {
    switch (status) {
      case ActivityFilter.mendatang:
        return 'Belum Mulai';
      case ActivityFilter.berlangsung:
        return 'Berlangsung';
      case ActivityFilter.selesai:
        return 'Selesai';
    }
  }

  @override
  Widget build(BuildContext context) {
    const borderBlue = Color(0xFF9ED1F5);
    const headerBlue = Color(0xFFDDF3FF);
    const darkBlue = Color(0xFF10498D);

    final Color statusBg = _isBerlangsung ? const Color(0xFFEFFFF9) : const Color(0xFFFFF6E0);
    final Color statusText = _isBerlangsung ? const Color(0xFF049E67) : const Color(0xFFD79A00);
    final Color dotColor = _isBerlangsung ? const Color(0xFF02C26A) : const Color(0xFF9AA3AF);
    final Color buttonBg = _isBerlangsung ? const Color(0xFF175FA4) : const Color(0xFFD1D5DB);
    final Color buttonFg = _isBerlangsung ? Colors.white : Colors.black;

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
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: headerBlue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start, // penting agar date tetap di pojok saat title tinggi
                    children: [
                      // Judul event: multi-line
                      Expanded(
                        child: Text(
                          eventName,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: darkBlue,
                          ),
                          softWrap: true,
                          // `maxLines: null` = tanpa batas baris (boleh tinggi)
                          // Bisa juga batasi misal 3 baris: maxLines: 3, overflow: TextOverflow.ellipsis,
                          // tapi permintaanmu ingin melebar ke bawah, jadi biar null.
                          maxLines: null,
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Tanggal di kanan, tetap satu baris
                      Text(
                        eventDate,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: darkBlue,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                // ===== Bawah =====
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'Status:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF7A869A),
                          ),
                        ),
                        const SizedBox(width: 8),

                        // chip status
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: statusBg,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            statusMap(status),
                            style: TextStyle(
                              color: statusText,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),

                        // bulatan hijau/abu
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: dotColor,
                          ),
                        ),
                      ],
                    ),

                    // tombol kanan
                    (status == ActivityFilter.mendatang)? SizedBox.shrink() :
                   TextButton.icon(
                        onPressed: onActionTap,
                        icon: Icon(
                          switch (status) {
                            ActivityFilter.mendatang =>
                              Icons.calendar_month,
                            ActivityFilter.berlangsung =>
                              Icons.qr_code_scanner,
                            ActivityFilter.selesai =>
                              Icons.download,
                          },
                          color: buttonFg,
                        ),
                        label: Text(
                          switch (status) {
                            ActivityFilter.mendatang =>
                            "Tunggu",
                            ActivityFilter.berlangsung =>
                            "Scan",
                            ActivityFilter.selesai =>
                            "Sertif",
                          },
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: buttonFg,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: buttonBg,
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
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

