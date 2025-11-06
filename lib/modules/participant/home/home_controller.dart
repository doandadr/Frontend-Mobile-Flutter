import 'package:frontend_mobile_flutter/data/network/services/home_service.dart';
import 'package:get/get.dart';

import '../../../core/utils.dart';
import '../../../data/models/event/event.dart';

enum HomeFilter { none, active, upcoming, past }

class HomeController extends GetxController {
  final service = Get.find<HomeService>();

  final isLoading = false.obs;

  // Cached lists in controller (backed by service cache too)
  final allEvents = <Event>[].obs;

  final activeEvents = <Event>[].obs;
  final upcomingEvents = <Event>[].obs;
  final pastEvents = <Event>[].obs;
  // DateTime dateTimeNow = DateTime.now();

  // current active chip index: null (none) => show all
  final Rxn<HomeFilter> activeFilter = Rxn<HomeFilter>(null);
  final searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadAll();
  }

//   bool canRegister(Event event) {
//     DateTime? startRegistration = Utils.toDateTimeFlexible(
//       event.pendaftaranMulai,
//     );
//     DateTime? endRegistration = Utils.toDateTimeFlexible(
//       event.pendaftaranSelesai,
//     );
//     DateTime? startEvent = Utils.toDateTimeFlexible(event.acaraMulai);
//
//     if (startEvent == null) {
//       return false;
//     }
//
//     return ["public", "private"].contains(event.kategori) &&
//         event.status == "active" &&
//         startEvent.isAfter(dateTimeNow);
//     /*
//         && (startRegistration.isAfter(dateTimeNow))
//         && (endRegistration.isBefore(dateTimeNow));
// */
//   }

  Future<void> _loadAll() async {
    try {
      isLoading.value = true;

      final a = await service.fetchAllEvents();
      final b = await service.fetchActiveEvents();
      final c = await service.fetchUpcomingEvents();
      final d = await service.fetchPastEvents();

      allEvents.assignAll(a);
      activeEvents.assignAll(b);
      upcomingEvents.assignAll(c);
      pastEvents.assignAll(d);
    } catch (e) {
      Get.snackbar(
        "Error loading data",
        "An unexpected error occurred: ${e.toString()}",
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Toggle filter chips. If same filter tapped twice -> deactivate (null -> show all)
  void toggleFilter(HomeFilter filter) {
    if (activeFilter.value == filter) {
      activeFilter.value = null; // show all
    } else {
      activeFilter.value = filter;
    }
  }

  /// Returns the current visible list based on activeFilter (null => all)
  List<Event> get visibleEvents {
    List<Event> events;
    final f = activeFilter.value;
    if (f == null) {
      events = allEvents;
    } else {
      switch (f) {
        case HomeFilter.active:
          return activeEvents;
        case HomeFilter.upcoming:
          events = upcomingEvents;
          break;
        case HomeFilter.past:
          events = pastEvents;
          break;
        case HomeFilter.none:
        default:
          events = allEvents;
          break;
      }
    }

    if (searchQuery.value.isEmpty) {
      return events;
    } else {
      return events
          .where(
            (event) =>
                "${event.nama.toLowerCase()} ${(event.lokasi == null) ? "" : event.lokasi?.toLowerCase()} ${event.deskripsi.toLowerCase()}"
                    .contains(searchQuery.value.toLowerCase()),
          )
          .toList();
    }
  }

  Future<void> refreshEvents() async {
    _loadAll();
  }

  HomeFilter getFilter(Event event) {
    if (activeEvents.contains(event)) {
      return HomeFilter.active;
    } else if (upcomingEvents.contains(event)) {
      return HomeFilter.upcoming;
    } else {
      return HomeFilter.past;
    }
  }

}
