// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventDetailResponse _$EventDetailResponseFromJson(Map<String, dynamic> json) =>
    EventDetailResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventDetailResponseToJson(
  EventDetailResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};

Data _$DataFromJson(Map<String, dynamic> json) => Data(
  event: json['event'] == null
      ? null
      : Event.fromJson(json['event'] as Map<String, dynamic>),
);

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
  'event': instance.event,
};

Event _$EventFromJson(Map<String, dynamic> json) => Event(
  id: Event._toInt(json['id']),
  kode: json['kode'] as String,
  slug: json['slug'] as String,
  nama: json['nama'] as String,
  deskripsi: json['deskripsi'] as String? ?? '',
  tipe: json['tipe'] as String? ?? '',
  statusAcara: json['status_acara'] as String? ?? '',
  lokasi: json['lokasi'] as String? ?? '',
  latitude: json['latitude'],
  longitude: json['longitude'],
  radius: json['radius'],
  pendaftaran: json['pendaftaran'] == null
      ? null
      : Acara.fromJson(json['pendaftaran'] as Map<String, dynamic>),
  acara: json['acara'] == null
      ? null
      : Acara.fromJson(json['acara'] as Map<String, dynamic>),
  kapasitas: json['kapasitas'] == null
      ? null
      : Kapasitas.fromJson(json['kapasitas'] as Map<String, dynamic>),
  status: json['status'] as String? ?? '',
  banner: json['banner'] as String? ?? '',
  catatan: json['catatan'] as String? ?? '',
  createdAt: json['created_at'] as String? ?? '',
);

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
  'id': instance.id,
  'kode': instance.kode,
  'slug': instance.slug,
  'nama': instance.nama,
  'deskripsi': instance.deskripsi,
  'tipe': instance.tipe,
  'status_acara': instance.statusAcara,
  'lokasi': instance.lokasi,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'radius': instance.radius,
  'pendaftaran': instance.pendaftaran,
  'acara': instance.acara,
  'kapasitas': instance.kapasitas,
  'status': instance.status,
  'banner': instance.banner,
  'catatan': instance.catatan,
  'created_at': instance.createdAt,
};

Acara _$AcaraFromJson(Map<String, dynamic> json) => Acara(
  mulai: json['mulai'] as String? ?? '',
  selesai: json['selesai'] as String? ?? '',
  mulaiRaw: Acara._toDateTimeNullable(json['mulai_raw']),
  selesaiRaw: Acara._toDateTimeNullable(json['selesai_raw']),
  isOpen: json['is_open'] == null ? false : Acara._toBool(json['is_open']),
);

Map<String, dynamic> _$AcaraToJson(Acara instance) => <String, dynamic>{
  'mulai': instance.mulai,
  'selesai': instance.selesai,
  'mulai_raw': instance.mulaiRaw?.toIso8601String(),
  'selesai_raw': instance.selesaiRaw?.toIso8601String(),
  'is_open': instance.isOpen,
};

Kapasitas _$KapasitasFromJson(Map<String, dynamic> json) =>
    Kapasitas(offline: json['offline'], online: json['online']);

Map<String, dynamic> _$KapasitasToJson(Kapasitas instance) => <String, dynamic>{
  'offline': instance.offline,
  'online': instance.online,
};
