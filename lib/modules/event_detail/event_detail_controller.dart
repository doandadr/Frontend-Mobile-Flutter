import 'package:frontend_mobile_flutter/data/models/pendaftaran/my_registration.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../app_pages.dart';
import '../../data/models/event/event_detail.dart';
import '../../data/network/services/pendaftaran_service.dart';
import '../../data/network/services/event_detail_service.dart';

enum AttendanceMethod {online,offline,hybrid}
class EventDetailController extends GetxController {
  final EventDetailService eventService;
  final PendaftaranService daftarService;

  EventDetailController(this.eventService, this.daftarService);

  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final eventDetail = Rxn<EventDetail>();
  final registrationInfo = Rxn<MyRegistration>();
  final isRegistered = false.obs;
  final isUserLoggedIn = false.obs;
  DateTime dateTimeNow = DateTime.now();
  // === State untuk dialog kehadiran (GetX) ===
  final selectedMethod = AttendanceMethod.online.obs;
  final isConfirmed = false.obs;

  void setMethod(AttendanceMethod m) {
    selectedMethod.value = m;
    print('[DEBUG] Nilai selectedMethod berubah menjadi: $m');
    // opsional: reset konfirmasi jika pindah ke online
    if (m == AttendanceMethod.online) isConfirmed.value = false;
  }

  void toggleConfirmed([bool? v]) {
    isConfirmed.value = v ?? !isConfirmed.value;
  }

  bool get isButtonEnabled => isConfirmed.value;

  String get tipeKehadiran {
    switch (selectedMethod.value) {
      case AttendanceMethod.online:
        return 'online';
      case AttendanceMethod.offline:
        return 'offline';
      case AttendanceMethod.hybrid:
        return 'hybrid';
    }
  }

  void resetAttendanceState() {
    selectedMethod.value = AttendanceMethod.online;
    isConfirmed.value = false;
  }

  Future<void> loadEventDetail(int id) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final storage = Get.find<GetStorage>();
      isUserLoggedIn.value = storage.hasData('access_token');

      final detail = await eventService.getEventDetail(id);
      eventDetail.value = detail?.data;

      if (isUserLoggedIn.value) {
        isRegistered.value = await daftarService.isRegistered(id);
      } else {
        isRegistered.value = false;
      }
    } catch (e) {
      errorMessage.value = e.toString();
      eventDetail.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadRegistration(int id) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final storage = Get.find<GetStorage>();
      isUserLoggedIn.value = storage.hasData('access_token');

      final detail = await daftarService.fetchMyEventDetail(id);
      registrationInfo.value = detail;

      if (isUserLoggedIn.value) {
        isRegistered.value = await daftarService.isRegistered(id);
      } else {
        isRegistered.value = false;
      }
    } catch (e) {
      errorMessage.value = e.toString();
      registrationInfo.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<String?> register(int id,String tipeKehadiran) async {
    final result = await daftarService.daftarEvent(id,tipeKehadiran);
    if (result == null) return "Unexpected error";

    if (result.success) {
      isRegistered.value = true;
      Get.snackbar('Berhasil', 'Anda berhasil mendaftar acara.');
      return null;
    } else {
      Get.snackbar('Gagal', result.message);
      return result.message;
    }
  }
  
  // New method for canceling registration
  Future<String?> cancelRegistration(int id) async {
    // NOTE: This assumes 'batalDaftar' exists in your PendaftaranService
    final result = await daftarService.batalDaftar(id);

    if (result.success) {
      isRegistered.value = false;
      Get.snackbar('Berhasil', 'Pendaftaran Anda telah dibatalkan.');
      return null;
    } else {
      Get.snackbar('Gagal', result.message);
      return result.message;
    }
  }

  // New method for QR Scan (dummy)
  void scanQrCode() {
    // This is a dummy implementation as requested
    Get.snackbar('Fitur Segera Hadir', 'Fitur pemindaian QR akan segera tersedia.');
    // In a real implementation, you might navigate to a scanner page
    Get.toNamed(Routes.SCAN);
  }

  // New method to navigate to login
  void goToLogin() {
    Get.toNamed(Routes.AUTH); // Navigate to the authentication page
  }


  bool get hasError => errorMessage.isNotEmpty;
  bool get hasData => eventDetail.value != null;
}