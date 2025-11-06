// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventDetailResponse _$EventDetailResponseFromJson(Map<String, dynamic> json) =>
    EventDetailResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: EventDetail.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventDetailResponseToJson(
  EventDetailResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data.toJson(),
};

EventDetail _$EventDetailFromJson(Map<String, dynamic> json) => EventDetail(
  id: (json['id'] as num).toInt(),
  userId: (json['user_id'] as num).toInt(),
  kode: json['mdl_kode'] as String,
  slug: json['mdl_slug'] as String,
  nama: json['mdl_nama'] as String,
  deskripsi: json['mdl_deskripsi'] as String,
  tipe: json['mdl_tipe'] as String,
  kategori: json['mdl_kategori'] as String,
  lokasi: json['mdl_lokasi'] as String?,
  latitude: json['mdl_latitude'] as String?,
  longitude: json['mdl_longitude'] as String?,
  radius: (json['mdl_radius'] as num?)?.toInt(),
  pendaftaranMulai: DateTime.parse(json['mdl_pendaftaran_mulai'] as String),
  pendaftaranSelesai: DateTime.parse(json['mdl_pendaftaran_selesai'] as String),
  maksPesertaEksternal: (json['mdl_maks_peserta_eksternal'] as num?)?.toInt(),
  acaraMulai: DateTime.parse(json['mdl_acara_mulai'] as String),
  acaraSelesai: json['mdl_acara_selesai'] == null
      ? null
      : DateTime.parse(json['mdl_acara_selesai'] as String),
  status: json['mdl_status'] as String,
  isPublic: (json['is_public'] as num).toInt(),
  presensiAktif: (json['mdl_presensi_aktif'] as num).toInt(),
  kodeQr: json['mdl_kode_qr'] as String?,
  linkWa: json['mdl_link_wa'] as String?,
  fileAcara: json['mdl_file_acara'] as String?,
  fileRundown: json['mdl_file_rundown'] as String?,
  templateSertifikat: json['mdl_template_sertifikat'] as String?,
  sertifikatAktif: (json['mdl_sertifikat_aktif'] as num).toInt(),
  doorprizeAktif: (json['mdl_doorprize_aktif'] as num).toInt(),
  bannerAcara: json['mdl_banner_acara'] as String?,
  catatan: json['mdl_catatan'] as String?,
);

Map<String, dynamic> _$EventDetailToJson(EventDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'mdl_kode': instance.kode,
      'mdl_slug': instance.slug,
      'mdl_nama': instance.nama,
      'mdl_deskripsi': instance.deskripsi,
      'mdl_tipe': instance.tipe,
      'mdl_kategori': instance.kategori,
      'mdl_lokasi': instance.lokasi,
      'mdl_latitude': instance.latitude,
      'mdl_longitude': instance.longitude,
      'mdl_radius': instance.radius,
      'mdl_pendaftaran_mulai': instance.pendaftaranMulai.toIso8601String(),
      'mdl_pendaftaran_selesai': instance.pendaftaranSelesai.toIso8601String(),
      'mdl_maks_peserta_eksternal': instance.maksPesertaEksternal,
      'mdl_acara_mulai': instance.acaraMulai.toIso8601String(),
      'mdl_acara_selesai': instance.acaraSelesai?.toIso8601String(),
      'mdl_status': instance.status,
      'is_public': instance.isPublic,
      'mdl_presensi_aktif': instance.presensiAktif,
      'mdl_kode_qr': instance.kodeQr,
      'mdl_link_wa': instance.linkWa,
      'mdl_file_acara': instance.fileAcara,
      'mdl_file_rundown': instance.fileRundown,
      'mdl_template_sertifikat': instance.templateSertifikat,
      'mdl_sertifikat_aktif': instance.sertifikatAktif,
      'mdl_doorprize_aktif': instance.doorprizeAktif,
      'mdl_banner_acara': instance.bannerAcara,
      'mdl_catatan': instance.catatan,
    };
