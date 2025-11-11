// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_registration_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyRegistrationEvent _$MyRegistrationEventFromJson(
  Map<String, dynamic> json,
) => MyRegistrationEvent(
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
  acaraSelesai: DateTime.parse(json['mdl_acara_selesai'] as String),
  status: json['mdl_status'] as String,
  isPublic: (json['is_public'] as num).toInt(),
  presensiAktif: (json['mdl_presensi_aktif'] as num).toInt(),
  kodeQr: json['mdl_kode_qr'] as String?,
  linkWa: json['mdl_link_wa'] as String?,
  sertifikatAktif: (json['mdl_sertifikat_aktif'] as num).toInt(),
  doorprizeAktif: (json['mdl_doorprize_aktif'] as num).toInt(),
  catatan: json['mdl_catatan'] as String?,
  bannerAcaraUrl: json['mdl_banner_acara_url'] as String?,
  fileAcaraUrl: json['mdl_file_acara_url'] as String?,
  fileRundownUrl: json['mdl_file_rundown_url'] as String?,
  templateSertifikatUrl: json['mdl_template_sertifikat_url'] as String?,
);

Map<String, dynamic> _$MyRegistrationEventToJson(
  MyRegistrationEvent instance,
) => <String, dynamic>{
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
  'mdl_acara_selesai': instance.acaraSelesai.toIso8601String(),
  'mdl_status': instance.status,
  'is_public': instance.isPublic,
  'mdl_presensi_aktif': instance.presensiAktif,
  'mdl_kode_qr': instance.kodeQr,
  'mdl_link_wa': instance.linkWa,
  'mdl_sertifikat_aktif': instance.sertifikatAktif,
  'mdl_doorprize_aktif': instance.doorprizeAktif,
  'mdl_catatan': instance.catatan,
  'mdl_banner_acara_url': instance.bannerAcaraUrl,
  'mdl_file_acara_url': instance.fileAcaraUrl,
  'mdl_file_rundown_url': instance.fileRundownUrl,
  'mdl_template_sertifikat_url': instance.templateSertifikatUrl,
};
