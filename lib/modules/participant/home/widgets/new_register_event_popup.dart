import 'package:flutter/material.dart';
import 'package:frontend_mobile_flutter/modules/participant/home/widgets/success_register.dart';
import 'package:get/get.dart';
import '../../../event_detail/event_detail_controller.dart';


class AttendanceDialog extends StatelessWidget {
  final int eventId;
  late final String? tipeKehadiran;
  late final String? urlWa;
  //online,offline,hybrid
  //grup wa

  AttendanceDialog({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<EventDetailController>();
    tipeKehadiran = c.eventDetail.value?.tipe;
    urlWa = c.eventDetail.value?.linkWa;
    final bool isHybrid = tipeKehadiran == 'hybrid';

    return Obx(() {
      final isButtonEnabled = c.isButtonEnabled;

      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      isHybrid ? 'Pilih Metode Kehadiran' : 'Konfirmasi Kehadiran',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Sembunyikan sub-judul jika bukan hybrid
              Visibility(
                visible: isHybrid,
                child: Text(
                  'Silakan pilih bagaimana Anda ingin mengikuti acara ini',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ),
              SizedBox(height: isHybrid ? 24 : 8),

              // Sembunyikan pilihan jika bukan hybrid
              Visibility(
                visible: isHybrid,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Online
                    _OptionCard(
                      method: AttendanceMethod.online,
                      title: 'Online',
                      subtitle: 'Ikuti acara via Zoom/Google Meet',
                      icon: Icons.computer_outlined,
                      iconColor: Colors.blue.shade700,
                      iconBgColor: Colors.blue.shade100,
                      groupValue: c.selectedMethod.value,
                      onSelected: c.setMethod,
                    ),
                    const SizedBox(height: 16),

                    // Offline
                    _OptionCard(
                      method: AttendanceMethod.offline,
                      title: 'Offline',
                      subtitle: 'Hadiri acara secara langsung di lokasi',
                      icon: Icons.location_on_outlined,
                      iconColor: Colors.green.shade700,
                      iconBgColor: Colors.green.shade100,
                      groupValue: c.selectedMethod.value,
                      onSelected: c.setMethod,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),

              // --- PERUBAHAN DI SINI ---
              // Tampilkan teks konfirmasi HANYA jika bukan hybrid
              Visibility(
                visible: !isHybrid,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Text(
                    'Apakah anda yakin bisa hadir pada event ini?',
                    style: TextStyle(
                        color: Colors.grey.shade700,
                        fontStyle: FontStyle.italic
                    ),
                  ),
                ),
              ),
              // --- AKHIR PERUBAHAN ---

              // Checkbox ini SELALU tampil
              Padding(
                // Beri padding atas hanya jika hybrid (karena non-hybrid sudah ada)
                padding: EdgeInsets.only(top: isHybrid ? 8.0 : 0.0),
                child: InkWell(
                  onTap: () => c.toggleConfirmed(),
                  borderRadius: BorderRadius.circular(4),
                  child: Row(
                    children: [
                      Checkbox(
                        value: c.isConfirmed.value,
                        onChanged: (v) => c.toggleConfirmed(v),
                      ),
                      const Flexible(child: Text('Saya Bersedia Hadir')),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Batal'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade700,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: isButtonEnabled
                ? () async {
              final err = await c.register(eventId, c.selectedMethod.value.name);
                if (err == null) {
                    //Kita pakai snackbar sekarang
                    Navigator.of(context).pop();
                    SuccessRegister.show(context,urlWhatsappGroup: urlWa,subtitle: "Silahkan masuk grup WhatsApp ini untuk info lebih lanjut");
                } else {

                }
                Get.back();
            }
                : null,
            child: const Text('Daftar'),
          ),
        ],
        actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      );
    });
  }
}

// Kartu opsi (stateless, dikontrol oleh controller)
// TIDAK ADA PERUBAHAN DI SINI
class _OptionCard extends StatelessWidget {
  final AttendanceMethod method;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final AttendanceMethod groupValue;
  final void Function(AttendanceMethod) onSelected;

  const _OptionCard({
    required this.method,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.groupValue,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = groupValue == method;

    return InkWell(
      onTap: () => onSelected(method),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blue.shade700 : Colors.grey.shade400,
            width: isSelected ? 2.0 : 1.0,
          ),
        ),
        child: Row(
          children: [
            Radio<AttendanceMethod>(
              value: method,
              groupValue: groupValue,
              onChanged: (v) {
                if (v != null) onSelected(v);
              },
            ),
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: iconBgColor,
              child: Icon(icon, color: iconColor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(height: 4),
                  Text(subtitle, style: TextStyle(color: Colors.grey.shade600)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}