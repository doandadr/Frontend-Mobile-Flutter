// import 'package:flutter/material.dart';
// import 'package:frontend_mobile_flutter/modules/participant/home/widgets/fail_register.dart';
// import 'package:frontend_mobile_flutter/modules/participant/home/widgets/success_register.dart';
// import 'package:get/get.dart';
//
// import '../../../event_detail/event_detail_controller.dart';
//
// class RegisterEventPopup extends StatefulWidget {
//   final void Function(bool agree, bool offline, bool online)? onSubmit;
//   final int eventId;
//
//   final bool initialAgree;
//   final bool initialOffline;
//   final bool initialOnline;
//
//   const RegisterEventPopup({
//     super.key,
//     this.onSubmit,
//     required this.eventId,
//     this.initialAgree = true, // sesuai mockup: sudah tercentang
//     this.initialOffline = false,
//     this.initialOnline = false,
//   });
//
//   /// Helper untuk menampilkan dialog
//   static Future<void> show(
//     BuildContext context, {
//     required int eventId,
//     void Function(bool, bool, bool)? onSubmit,
//   }) {
//     return showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (_) => Dialog(
//         insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
//         backgroundColor: Colors.transparent,
//         child: RegisterEventPopup(onSubmit: onSubmit, eventId: eventId),
//       ),
//     );
//   }
//
//   @override
//   State<RegisterEventPopup> createState() => _RegisterEventPopupState();
// }
//
// class _RegisterEventPopupState extends State<RegisterEventPopup> {
//   final EventDetailController controller = Get.find<EventDetailController>();
//   // Warna2 yang mirip desain
//   static const _primaryBlue = Color(0xFF135CB5);
//   static const _checkGreen = Color(0xFF22C55E);
//   static const _bgWhite = Colors.white;
//   static const _textGrey = Color(0xFF6B7280);
//   static const _outlineGrey = Color(0xFFE5E7EB);
//
//   late bool agree = widget.initialAgree;
//   late bool offline = widget.initialOffline;
//   late bool online = widget.initialOnline;
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       borderRadius: BorderRadius.circular(18),
//       color: _bgWhite,
//       child: ConstrainedBox(
//         constraints: const BoxConstraints(minWidth: 280, maxWidth: 380),
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // Baris close (X)
//               Row(
//                 children: [
//                   const Spacer(),
//                   InkWell(
//                     borderRadius: BorderRadius.circular(20),
//                     onTap: () => Navigator.of(context).pop(),
//                     child: const Padding(
//                       padding: EdgeInsets.all(6),
//                       child: Icon(Icons.close, size: 22),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 4),
//
//               // Checkbox utama (hijau terisi)
//               _CheckRow(
//                 checked: agree,
//                 onChanged: (v) => setState(() => agree = v),
//                 title: 'saya bersedia mengikuti\nkegiatan acara ini',
//                 filledStyle: true, // hijau terisi
//                 titleStyle: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black,
//                   height: 1.25,
//                 ),
//               ),
//               const SizedBox(height: 12),
//
//               // Offline
//               _CheckRow(
//                 checked: offline,
//                 onChanged: (v) => setState(() => offline = v),
//                 title: 'Saya bersedia offline',
//                 titleStyle: const TextStyle(
//                   fontSize: 16,
//                   color: _textGrey,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(height: 8),
//
//               // Online
//               _CheckRow(
//                 checked: online,
//                 onChanged: (v) => setState(() => online = v),
//                 title: 'Saya bersedia online',
//                 titleStyle: const TextStyle(
//                   fontSize: 16,
//                   color: _textGrey,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//
//               // Tombol submit
//               SizedBox(
//                 width: double.infinity,
//                 height: 48,
//                 child: ElevatedButton(
//                   onPressed: agree
//                       ? () async {
//                           final errorMessage = await controller.register(
//                             widget.eventId,
//                           );
//                           if (mounted) {
//                             if (errorMessage == null) {
//                               SuccessRegister.show(context, title: 'SUCCESS', subtitle: 'Pendaftaran Berhasil');
//                             } else {
//                               FailRegister.show(context, title: 'FAILED', subtitle: errorMessage);
//                             }
//                           }
//                         }
//                       : null,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: _primaryBlue,
//                     disabledBackgroundColor: _primaryBlue.withOpacity(.4),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                   ),
//                   child: const Text(
//                     'Submit Pendaftaran',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w700,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// /// Satu baris checkbox bergaya kartu/outline, bisa “filled” (hijau solid)
// class _CheckRow extends StatelessWidget {
//   final bool checked;
//   final ValueChanged<bool> onChanged;
//   final String title;
//   final TextStyle? titleStyle;
//   final bool filledStyle;
//
//   const _CheckRow({
//     required this.checked,
//     required this.onChanged,
//     required this.title,
//     this.titleStyle,
//     this.filledStyle = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     const green = _RegisterEventPopupState._checkGreen;
//     const outline = _RegisterEventPopupState._outlineGrey;
//
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         InkWell(
//           onTap: () => onChanged(!checked),
//           borderRadius: BorderRadius.circular(8),
//           child: AnimatedContainer(
//             duration: const Duration(milliseconds: 150),
//             width: 28,
//             height: 28,
//             decoration: BoxDecoration(
//               color: checked
//                   ? green
//                   : Colors.transparent, // kasih warna hijau saat dipilih
//               borderRadius: BorderRadius.circular(6),
//               border: Border.all(color: checked ? green : outline, width: 2),
//             ),
//             child: checked
//                 ? const Icon(Icons.check, size: 18, color: Colors.white)
//                 : null, // tampilkan icon check
//           ),
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: GestureDetector(
//             onTap: () => onChanged(!checked),
//             child: Text(title, style: titleStyle),
//           ),
//         ),
//       ],
//     );
//   }
// }
