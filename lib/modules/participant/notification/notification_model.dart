import 'package:get/get.dart';

/// Model untuk merepresentasikan satu item notifikasi.
class NotificationModel {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  // isUnread dibuat reaktif (RxBool) agar UI bisa langsung update saat statusnya berubah.
  final RxBool isUnread;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    required bool isUnread,
  }) : isUnread = RxBool(isUnread); // Menginisialisasi RxBool dari nilai boolean biasa.
}
