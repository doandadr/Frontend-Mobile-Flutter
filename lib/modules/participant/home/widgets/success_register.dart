import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SuccessRegister extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? urlWhatsappGroup;

  const SuccessRegister({
    super.key,
    this.title = 'SUCCESS',
    this.subtitle = 'Pendaftaran Berhasil',
    this.urlWhatsappGroup,
  });

  static Future<void> show(
      BuildContext context, {
        String title = 'SUCCESS',
        String subtitle = 'Pendaftaran Berhasil',
        String? urlWhatsappGroup,
      }) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        backgroundColor: Colors.transparent,
        child: SuccessRegister(
          title: title,
          subtitle: subtitle,
          urlWhatsappGroup: urlWhatsappGroup,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF22C55E);
    const greyText = Color(0xFF6B7280);

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Spacer(),
                InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => Navigator.of(context).pop(),
                  child: const Padding(
                    padding: EdgeInsets.all(6),
                    child: Icon(Icons.close, size: 22),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),

            Container(
              width: 82,
              height: 82,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: green,
              ),
              child: Icon(
                urlWhatsappGroup == null
                    ? Icons.check
                    : FontAwesomeIcons.whatsapp,
                size: 44,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: green,
                fontSize: 24,
                fontWeight: FontWeight.w800,
                letterSpacing: .5,
              ),
            ),
            const SizedBox(height: 8),

            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: greyText,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),

            if (urlWhatsappGroup != null)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () async {
                    final uri = Uri.parse(urlWhatsappGroup!);
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Gabung',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
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
