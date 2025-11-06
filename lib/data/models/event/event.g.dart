// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
  id: (json['id'] as num).toInt(),
  userId: (json['user_id'] as num?)?.toInt(),
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
  pendaftaranMulai: json['mdl_pendaftaran_mulai'] as String,
  pendaftaranSelesai: json['mdl_pendaftaran_selesai'] as String,
  maksPesertaEksternal: (json['mdl_maks_peserta_eksternal'] as num?)?.toInt(),
  acaraMulai: json['mdl_acara_mulai'] as String,
  acaraSelesai: json['mdl_acara_selesai'] as String?,
  status: json['mdl_status'] as String,
  isPublic: (json['is_public'] as num).toInt(),
  mediaUrls: json['media_urls'] == null
      ? null
      : MediaUrls.fromJson(json['media_urls'] as Map<String, dynamic>),
);

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
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
  'mdl_pendaftaran_mulai': instance.pendaftaranMulai,
  'mdl_pendaftaran_selesai': instance.pendaftaranSelesai,
  'mdl_maks_peserta_eksternal': instance.maksPesertaEksternal,
  'mdl_acara_mulai': instance.acaraMulai,
  'mdl_acara_selesai': instance.acaraSelesai,
  'mdl_status': instance.status,
  'is_public': instance.isPublic,
  'media_urls': instance.mediaUrls,
};

MediaUrls _$MediaUrlsFromJson(Map<String, dynamic> json) =>
    MediaUrls(banner: json['banner'] as String?);

Map<String, dynamic> _$MediaUrlsToJson(MediaUrls instance) => <String, dynamic>{
  'banner': instance.banner,
};
