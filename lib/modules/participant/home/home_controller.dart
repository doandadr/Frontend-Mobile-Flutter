import 'package:frontend_mobile_flutter/core/logger.dart';
import 'package:frontend_mobile_flutter/data/network/services/home_service.dart';
import 'package:get/get.dart';

import '../../../data/models/event/event.dart';

enum HomeFilter { none, active, upcoming, past, open, closed }

class HomeController extends GetxController {
  final service = Get.find<HomeService>();

  final RxBool isLoading = false.obs;
  final timeNow = DateTime.now();

  final allEvents = <Event>[].obs;
  final activeEvents = <Event>[].obs;
  final upcomingEvents = <Event>[].obs;
  final pastEvents = <Event>[].obs;
  final openEvents = <Event>[].obs;
  final closedEvents = <Event>[].obs;

  final Rxn<HomeFilter> activeFilter = Rxn<HomeFilter>(null);
  final searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadAll();
  }

  bool _isUpcoming(Event event) {
    DateTime startRegistration = event.pendaftaranMulai;

    return timeNow.isBefore(startRegistration);
  }

  bool _isOpen(Event event) {
    DateTime startRegistration = event.pendaftaranMulai;
    DateTime endRegistration = event.pendaftaranSelesai;

    return timeNow.isAfter(startRegistration) && timeNow.isBefore(endRegistration);
  }

  bool _isClosed(Event event) {
    DateTime endRegistration = event.pendaftaranSelesai;
    DateTime startEvent = event.acaraMulai;

    return timeNow.isAfter(endRegistration) && timeNow.isBefore(startEvent);
  }

  bool _isOngoing(Event event) {
    DateTime startEvent = event.acaraMulai;
    DateTime? endEvent = event.acaraSelesai;

    if (endEvent == null) return true;
    return timeNow.isAfter(startEvent) && timeNow.isBefore(endEvent);
  }

  bool _isPast(Event event) {
    DateTime? endEvent = event.acaraSelesai;

    if (endEvent == null) return false;
    return timeNow.isAfter(endEvent);
  }

  Future<void> _loadAll() async {
    try {
      isLoading.value = true;

      final a = await service.fetchAllEvents();
      allEvents.assignAll(a);
      upcomingEvents.assignAll(a.where((event) => _isUpcoming(event)));
      openEvents.assignAll(a.where((event) => _isOpen(event)));
      closedEvents.assignAll(a.where((event) => _isClosed(event)));
      activeEvents.assignAll(a.where((event) => _isOngoing(event)));
      pastEvents.assignAll(a.where((event) => _isPast(event)));
    } catch (e, stackTrace) {
      logger.e("Gagal memuat data home screen", error: e, stackTrace: stackTrace);
    } finally {
      isLoading.value = false;
    }
  }

  void toggleFilter(HomeFilter filter) {
    if (activeFilter.value == filter) {
      activeFilter.value = null;
    } else {
      activeFilter.value = filter;
    }
  }

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
        events = allEvents;
          break;
        case HomeFilter.open:
          events = openEvents;
          break;
        case HomeFilter.closed:
          events = closedEvents;
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

  Future<void> refreshEvents() => _loadAll();

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