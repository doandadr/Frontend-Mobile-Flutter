import 'package:dio/dio.dart';
import 'package:frontend_mobile_flutter/data/models/basic_response.dart';
import 'package:get/get.dart';

import '../../models/pendaftaran/my_registration.dart';
import '../../models/pendaftaran/pendaftaran_response.dart';
import '../api_client.dart';
import '../endpoints.dart';

class PendaftaranService extends GetxService {
  final Dio _dio = ApiClient.dio;

  Future<BasicResponse> batalDaftar(int eventId) async {
    try {
      final resp = await _dio.delete("${Endpoints.events}/$eventId/batal-daftar");
      return BasicResponse.fromJson(resp.data);
    } on DioException catch (e) {
      return BasicResponse(
        success: false,
        message: e.response?.data["message"] ?? "Gagal membatalkan acara",
      );
    }
  }

  Future<PendaftaranResponse?> daftarEvent(int eventId,String tipeKehadiran) async {
    try {
      final resp = await _dio.post("${Endpoints.events}/$eventId/daftar"
      ,data:{
            "tipe_kehadiran":tipeKehadiran
          }
      );
      return PendaftaranResponse.fromJson(resp.data);
    } on DioException catch (e) {
      return PendaftaranResponse(
        success: false,
        message: e.response?.data["message"] ?? "Gagal mendaftar acara",
      );
    }
  }

  // Future<List<MyRegistration>> fetchMyEvents() async {
  //   try {
  //     final resp = await _dio.get(Endpoints.followedEvents);
  //
  //     final list = (resp.data["data"]["data"] as List<dynamic>)
  //         .map((e) => MyRegistration.fromJson(e))
  //         .toList();
  //
  //     return list;
  //   } catch (_) {
  //     return [];
  //   }
  // }

  Future<MyRegistration?> fetchMyEventDetail(int eventId) async {
    try {
      final resp = await _dio.get("${Endpoints.followedEventDetail}/$eventId/me");
      return MyRegistration.fromJson(resp.data["data"]);
    } catch (_) {
      return null;
    }
  }

  Future<bool> isRegistered(int eventId) async {
    try {
      final resp = await _dio.get("${Endpoints.events}/$eventId/me");
      return resp.data["success"] == true;
    } catch (_) {
      return false;
    }
  }

}
