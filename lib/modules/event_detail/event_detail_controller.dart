import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../core/utils.dart';
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
  final eventDetail = Rxn<Event>();
  final isRegistered = false.obs;
  final isUserLoggedIn = false.obs;
  DateTime dateTimeNow = DateTime.now();


  bool canRegister(Event event) {
    // DateTime? startRegistration = Utils.toDateTimeFlexible(
    //   event.pendaftaran?.mulai,
    // );
    // DateTime? endRegistration = Utils.toDateTimeFlexible(
    //   event.pendaftaran?.selesai,
    // );
    DateTime? startEvent = Utils.toDateTimeFlexible(event.acara?.mulai);

    if (startEvent == null) {
      return false;
    }

    return event.status == "active" &&
        startEvent.isAfter(dateTimeNow);
    /*
        && (startRegistration.isAfter(dateTimeNow))
        && (endRegistration.isBefore(dateTimeNow));
    */
  }


  ActivityFilter eventStatus(Datum d) {
    final startTime = Utils.parseDate(d.modulAcara?.mdlAcaraMulai);
    final endTime = Utils.parseDate(d.modulAcara?.mdlAcaraSelesai);
    final now = DateTime.now();

    if (startTime == null) return ActivityFilter.selesai;

    if (startTime.isAfter(now)) return ActivityFilter.mendatang;
    if (endTime == null || endTime.isAfter(now)) return ActivityFilter.berlangsung;
    return ActivityFilter.selesai;
  }


  Future<void> loadEventDetail(int id) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final storage = GetStorage();
      isUserLoggedIn.value = storage.hasData('access_token');

      final detail = await eventService.getEventDetail(id);
      eventDetail.value = detail?.data?.event;

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

  bool get hasError => errorMessage.isNotEmpty;
  bool get hasData => eventDetail.value != null;
}
