import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../models/event/event_detail.dart';
import '../api_client.dart';
import '../endpoints.dart';

class EventDetailService extends GetxService {
  Future<EventDetailResponse?> getEventDetail(int id) async {
    try {
      final resp = await ApiClient.dio.get('${Endpoints.eventDetail}/$id');

      // Tampilkan log JSON utuh (tidak “kepotong”)
      try {
        debugPrint(jsonEncode(resp.data), wrapWidth: 4096);
      } catch (_) {
        // fallback
        debugPrint('${resp.data}', wrapWidth: 4096);
      }

      if (resp.data == null) return null;

      // Pastikan ke Map<String, dynamic>
      final root = _asJsonMap(resp.data);

      // (Opsional) Validasi minimal sesuai struktur kamu: { success, message, data: { event: {...} } }
      if (root['data'] == null) {
        throw const FormatException('Field "data" tidak ada pada respons.');
      }
      final dataMap = _asJsonMap(root['data']);
      if (dataMap['event'] == null) {
        throw const FormatException('Field "data.event" tidak ada pada respons.');
      }

      // Parse sesuai model envelope kamu
      final data = EventDetailResponse.fromJson(root);
      return data;

    } on DioException catch (e, s) {
      final msg = _extractServerMessage(e.response?.data) ?? 'Failed to retrieve event detail';
      debugPrint('DioException: $msg\n$e\n$s');
      throw Exception(msg);
    } on FormatException catch (e, s) {
      debugPrint('FormatException JSON/struktur: ${e.message}\n$s');
      throw Exception('Format data server tidak valid: ${e.message}');
    } on TypeError catch (e, s) {
      // Umum terjadi saat tipe field model ≠ tipe di JSON (misal id: "84" vs int)
      debugPrint('TypeError saat mapping model: $e\n$s');
      throw Exception('Struktur/tipe field tidak sesuai model. Cek mapping vs JSON.');
    } catch (e, s) {
      // Jangan tutupin error: log detailnya
      debugPrint('Unexpected error: $e\n$s');
      throw Exception(e.toString());
    }
  }

  Map<String, dynamic> _asJsonMap(dynamic data) {
    if (data is Map<String, dynamic>) return data;
    if (data is Map) return Map<String, dynamic>.from(data);
    if (data is String && data.isNotEmpty) {
      final decoded = jsonDecode(data);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
    }
    throw const FormatException('Response bukan JSON object');
  }

  String? _extractServerMessage(dynamic data) {
    try {
      final m = _asJsonMap(data);
      return (m['message'] as String?) ?? (m['error'] as String?) ?? (m['msg'] as String?);
    } catch (_) {
      return null;
    }
  }
}

// import 'package:dio/dio.dart';
// import 'package:get/get.dart';
//
// import '../../models/event/event_detail.dart';
// import '../api_client.dart';
// import '../endpoints.dart';
//
// class EventDetailService extends GetxService {
//   Future<EventDetailResponse?> getEventDetail(int id) async {
//     try {
//       final response = await ApiClient.dio.get('${Endpoints.eventDetail}/$id');
//       print('Response data: ${response.data}'); // Debug print
//       if (response.data == null) {
//         return null;
//       }
//
//       final data = EventDetailResponse.fromJson(response.data);
//       // Use null-safe access to prevent errors if parts of the response are null
//       return data;
//     } on DioException catch (e) {
//       // Throw a proper exception instead of a string
//       final errorMessage = e.response?.data?['message'] as String? ?? 'Failed to retrieve event detail';
//       throw Exception(errorMessage);
//     } catch (e) {
//       // Handle other potential errors gracefully
//       throw Exception('An unexpected error occurred. Please try again.');
//     }
//   }
// }
