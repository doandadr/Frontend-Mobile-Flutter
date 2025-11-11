import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../models/event/event.dart';
import '../api_client.dart';
import '../endpoints.dart';

class HomeService extends GetxService {
  Future<List<Event>> _fetchEvents(String endpoint, String cacheKey) async {
    try {
      final resp = await ApiClient.dio.get(endpoint);

      final payload = resp.data;
      final eventsJson = payload["data"]["events"] as List<dynamic>;

      final events = eventsJson.map((e) {
        return Event.fromJson(e as Map<String, dynamic>);
      }).toList();

      return events;
    } on DioException catch (e) {
      Get.snackbar("Network Error", e.message ?? "Failed to load events");
      return <Event>[];
    } catch (e) {
      Get.snackbar("Error", "Unexpected error while parsing dashboard data");
      return <Event>[];
    }
  }

  Future<List<Event>> fetchAllEvents() =>
      _fetchEvents(Endpoints.eventsAll, 'all');

  Future<List<Event>> fetchActiveEvents() =>
      _fetchEvents(Endpoints.events, 'active');

  Future<List<Event>> fetchUpcomingEvents() =>
      _fetchEvents(Endpoints.eventsUpcoming, 'upcoming');

  Future<List<Event>> fetchPastEvents() =>
      _fetchEvents(Endpoints.eventsPast, 'past');
}