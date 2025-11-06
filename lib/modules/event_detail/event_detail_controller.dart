import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../app_pages.dart';
import '../../core/utils.dart';
import '../../data/models/event/event.dart';
import '../../data/models/event/event_detail.dart';
import '../../data/models/event/followed_event.dart';
import '../../data/network/services/pendaftaran_service.dart';
import '../../data/network/services/event_detail_service.dart';
import '../participant/activity/activity_controller.dart';

class EventDetailController extends GetxController {
  final EventDetailService eventService;
  final PendaftaranService daftarService;

  EventDetailController(this.eventService, this.daftarService);

  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final eventDetail = Rxn<EventDetail>();
  final isRegistered = false.obs;
  final isUserLoggedIn = false.obs;
  DateTime dateTimeNow = DateTime.now();

  Future<void> loadEventDetail(int id) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final storage = GetStorage();
      isUserLoggedIn.value = storage.hasData('access_token');

      final detail = await eventService.getEventDetail(id);
      eventDetail.value = detail?.data.event;

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

  Future<String?> register(int id) async {
    final result = await daftarService.daftarEvent(id);
    if (result == null) return "Unexpected error";

    if (result.success) {
      isRegistered.value = true;
      return null;
    }

    return result.message;
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