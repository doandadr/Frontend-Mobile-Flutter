import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/utils.dart';

class AboutEventCard extends StatelessWidget {
  final Widget titleWidget;
  final String description;
  final Color primaryColor;

  ///(contoh: https://airnav-event.vercel.app/user/event/21)
  final String shareUrl;
  final String? shareMessage;

  final bool isLoggedIn;
  final bool isRegistered;
  final DateTime registrationStartDate;
  final DateTime registrationEndDate;
  final DateTime eventStartDate;
  final DateTime eventEndDate;
  final int isAttendanceActive;

  final VoidCallback? onRegister;
  final VoidCallback? onCancelRegistration;
  final VoidCallback? onScan;
  final VoidCallback? onLogin;

  const AboutEventCard({
    super.key,
    required this.titleWidget,
    required this.description,
    required this.shareUrl,
    this.shareMessage,
    this.primaryColor = const Color(0xFF005EA2),

    required this.isLoggedIn,
    required this.isRegistered,
    required this.registrationStartDate,
    required this.registrationEndDate,
    required this.eventStartDate,
    required this.eventEndDate,
    required this.isAttendanceActive,
    this.onRegister,
    this.onCancelRegistration,
    this.onScan,
    this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    String buttonText;
    Color buttonColor;
    VoidCallback? onPressed;
    final now = DateTime.now();

    if (!isLoggedIn) {
      buttonText = 'Login Untuk Mendaftar';
      buttonColor = Colors.grey;
      onPressed = onLogin; 
    } else if (!isRegistered) {
      // User login belum daftar
      if (now.isBefore(registrationStartDate)) {
        buttonText = 'Belum Dibuka';
        buttonColor = Colors.grey;
        onPressed = null;
      } else if (now.isAfter(registrationEndDate)) {
        buttonText = 'Pendaftaran Ditutup';
        buttonColor = Colors.grey;
        onPressed = null;
      } else {
        buttonText = 'Daftar Acara';
        buttonColor = primaryColor;
        onPressed = onRegister;
      }
    } else {
      // User login, sudah daftar
      if (now.isBefore(eventStartDate)) {
        buttonText = 'Batal Pendaftaran';
        buttonColor = Colors.red;
        onPressed = onCancelRegistration;
      } else if (now.isAfter(eventEndDate)) {
        buttonText = 'Absensi Ditutup';
        buttonColor = Colors.grey;
        onPressed = null;
      } else {
        if (isAttendanceActive == 1) {
          buttonText = 'Scan Absensi';
          buttonColor = primaryColor;
          onPressed = onScan;
        } else {
          buttonText = 'Belum Dimulai';
          buttonColor = Colors.grey;
          onPressed = null;
        }
      }
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            titleWidget,
            const SizedBox(height: 12),
            Text(
              description,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  disabledBackgroundColor: Colors.grey.shade500,
                ),
                child: Text(
                  buttonText,
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Bagikan Event',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  tooltip: 'Salin Link',
                  onPressed: () => _copyLink(context),
                  icon: const FaIcon(FontAwesomeIcons.copy),
                ),
                IconButton(
                  tooltip: 'Bagikan ke WhatsApp',
                  onPressed: _shareToWhatsApp,
                  icon: const FaIcon(
                    FontAwesomeIcons.whatsapp,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 4),
                IconButton(
                  tooltip: 'Bagikan ke Facebook',
                  onPressed: _shareToFacebook,
                  icon: const FaIcon(
                    FontAwesomeIcons.facebook,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 4),
                IconButton(
                  tooltip: 'Bagikan ke X',
                  onPressed: _shareToX,
                  icon: const FaIcon(
                    FontAwesomeIcons.xTwitter,
                    color: Colors.black,
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }



  void _copyLink(BuildContext context) async {
    final link = shareUrl.trim();
    if (link.isEmpty) return;
    await Clipboard.setData(ClipboardData(text: link));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Link disalin')),
    );
  }

  void _shareToWhatsApp() {
    final link = shareUrl.trim();
    if (link.isEmpty) return;
    final message = (shareMessage?.trim().isNotEmpty ?? false)
        ? '${shareMessage!.trim()} $link'
        : link;
    final waUrl = 'https://wa.me/?text=${Uri.encodeComponent(message)}';

    Utils.openUrl(waUrl);
  }

  void _shareToFacebook() {
    final link = shareUrl.trim();
    if (link.isEmpty) return;

    final message = (shareMessage?.trim().isNotEmpty ?? false)
        ? shareMessage!.trim()
        : link;

    final fbUrl =
        'https://www.facebook.com/sharer/sharer.php?u=${Uri.encodeComponent(link)}&quote=${Uri.encodeComponent(message)}';

    Utils.openUrl(fbUrl);
  }


  void _shareToX() {
    final link = shareUrl.trim();
    if (link.isEmpty) return;

    final message = (shareMessage?.trim().isNotEmpty ?? false)
        ? shareMessage!.trim()
        : '';

    final xUrl =
        'https://twitter.com/intent/tweet?text=${Uri.encodeComponent(message)}&url=${Uri.encodeComponent(link)}';

    Utils.openUrl(xUrl);
  }

}
