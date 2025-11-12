import 'package:frontend_mobile_flutter/data/models/certificate/certificate_response.dart';
import 'package:get/get.dart' hide Response;
import 'package:dio/dio.dart';

import 'package:frontend_mobile_flutter/data/network/api_client.dart';
import 'package:frontend_mobile_flutter/data/network/endpoints.dart';
import 'package:frontend_mobile_flutter/data/models/event/followed_event.dart';
import 'package:frontend_mobile_flutter/data/models/event/presence.dart';

import '../../models/event/scan_response.dart';

class ActivityService extends GetxService {
  final Dio _client = ApiClient.dio;

  /// GET daftar event yg diikuti
  Future<List<Datum>> getFollowedEvents({int page = 1}) async {
    try {
      final Response res = await _client.get(
        Endpoints.followedEvents,
        queryParameters: {'page': page},
      );

      final wrapped = FollowedEvent.fromJson(res.data as Map<String, dynamic>);
      return wrapped.data?.data ?? <Datum>[];
    } on DioException catch (e) {
      throw Exception(_msg(e, 'Gagal memuat events yang diikuti'));
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  Future<ScanResponse> sendPresence(Presence data) async {
    try {
      final Response res = await _client.post(
        Endpoints.presence,
        data: data.toJson(),
      );
      return ScanResponse.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      // ambil message dari server bila ada, tapi jangan throw agar UI 1 alur
      final body = e.response?.data;
      final msg = (body is Map && body['message'] != null)
          ? body['message'].toString()
          : 'Gagal mengirim presensi';
      return ScanResponse(status: false, message: msg);
    } catch (e) {
      return ScanResponse(status: false, message: 'Terjadi kesalahan: $e');
    }
  }

  Future<CertificateResponse> getCertificate(int eventId) async {
    final url = Endpoints.certificate.replaceAll("{eventId}", "$eventId");
    try {
      final Response res = await _client.post(url);
      return CertificateResponse.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      final data = e.response?.data;

      return CertificateResponse(
        status: data?["status"] ?? false,
        message: data?["message"] ?? "Gagal mengambil sertifikat.",
        data: null,
      );
    } catch (e) {
      // Untuk jaga-jaga jika error bukan dari Dio
      return CertificateResponse(
        status: false,
        message: "Terjadi kesalahan tak terduga: $e",
        data: null,
      );
    }
  }


  String _msg(DioException e, String fallback) {
    final data = e.response?.data;
    if (data is Map && data['message'] != null) return data['message'].toString();
    return fallback;
  }
}
