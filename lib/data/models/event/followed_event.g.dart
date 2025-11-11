// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'followed_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowedEvent _$FollowedEventFromJson(Map<String, dynamic> json) =>
    FollowedEvent(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FollowedEventToJson(FollowedEvent instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
  currentPage: (json['current_page'] as num).toInt(),
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
      .toList(),
  firstPageUrl: json['first_page_url'] as String,
  from: (json['from'] as num).toInt(),
  lastPage: (json['last_page'] as num).toInt(),
  lastPageUrl: json['last_page_url'] as String,
  links: (json['links'] as List<dynamic>?)
      ?.map((e) => Link.fromJson(e as Map<String, dynamic>))
      .toList(),
  nextPageUrl: json['next_page_url'] as String?,
  path: json['path'] as String,
  perPage: (json['per_page'] as num).toInt(),
  prevPageUrl: json['prev_page_url'] as String?,
  to: (json['to'] as num).toInt(),
  total: (json['total'] as num).toInt(),
);

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
  'current_page': instance.currentPage,
  'data': instance.data,
  'first_page_url': instance.firstPageUrl,
  'from': instance.from,
  'last_page': instance.lastPage,
  'last_page_url': instance.lastPageUrl,
  'links': instance.links,
  'next_page_url': instance.nextPageUrl,
  'path': instance.path,
  'per_page': instance.perPage,
  'prev_page_url': instance.prevPageUrl,
  'to': instance.to,
  'total': instance.total,
};

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
  id: (json['id'] as num).toInt(),
  modulAcaraId: (json['modul_acara_id'] as num).toInt(),
  userId: (json['user_id'] as num).toInt(),
  metodeDaftar: json['metode_daftar'] as String,
  waktuDaftar: json['waktu_daftar'] == null
      ? null
      : DateTime.parse(json['waktu_daftar'] as String),
  hasDoorprize: (json['has_doorprize'] as num).toInt(),
  noSertifikat: json['no_sertifikat'],
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  modulAcara: json['modul_acara'] == null
      ? null
      : ModulAcara.fromJson(json['modul_acara'] as Map<String, dynamic>),
  presensi: json['presensi'] == null
      ? null
      : MyRegistrationPresensi.fromJson(
          json['presensi'] as Map<String, dynamic>,
        ),
  user: json['user'] == null
      ? null
      : MyRegistrationUser.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
  'id': instance.id,
  'modul_acara_id': instance.modulAcaraId,
  'user_id': instance.userId,
  'metode_daftar': instance.metodeDaftar,
  'waktu_daftar': instance.waktuDaftar?.toIso8601String(),
  'has_doorprize': instance.hasDoorprize,
  'no_sertifikat': instance.noSertifikat,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
  'modul_acara': instance.modulAcara,
  'presensi': instance.presensi,
  'user': instance.user,
};

ModulAcara _$ModulAcaraFromJson(Map<String, dynamic> json) => ModulAcara(
  id: (json['id'] as num).toInt(),
  mdlKode: json['mdl_kode'] as String,
  mdlSlug: json['mdl_slug'] as String,
  mdlNama: json['mdl_nama'] as String,
  mdlKategori: json['mdl_kategori'] as String,
  mdlTipe: json['mdl_tipe'] as String,
  mdlLokasi: json['mdl_lokasi'] as String?,
  mdlAcaraMulai: json['mdl_acara_mulai'] == null
      ? null
      : DateTime.parse(json['mdl_acara_mulai'] as String),
  mdlAcaraSelesai: json['mdl_acara_selesai'] == null
      ? null
      : DateTime.parse(json['mdl_acara_selesai'] as String),
  mdlStatus: json['mdl_status'] as String,
  mdlKodeQr: json['mdl_kode_qr'] as String?,
  mdlBannerAcaraUrl: json['mdl_banner_acara_url'] as String?,
  mdlFileAcaraUrl: json['mdl_file_acara_url'] as String?,
  mdlFileRundownUrl: json['mdl_file_rundown_url'] as String?,
);

Map<String, dynamic> _$ModulAcaraToJson(ModulAcara instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mdl_kode': instance.mdlKode,
      'mdl_slug': instance.mdlSlug,
      'mdl_nama': instance.mdlNama,
      'mdl_kategori': instance.mdlKategori,
      'mdl_tipe': instance.mdlTipe,
      'mdl_lokasi': instance.mdlLokasi,
      'mdl_acara_mulai': instance.mdlAcaraMulai?.toIso8601String(),
      'mdl_acara_selesai': instance.mdlAcaraSelesai?.toIso8601String(),
      'mdl_status': instance.mdlStatus,
      'mdl_kode_qr': instance.mdlKodeQr,
      'mdl_banner_acara_url': instance.mdlBannerAcaraUrl,
      'mdl_file_acara_url': instance.mdlFileAcaraUrl,
      'mdl_file_rundown_url': instance.mdlFileRundownUrl,
    };

Link _$LinkFromJson(Map<String, dynamic> json) => Link(
  url: json['url'] as String?,
  label: json['label'] as String,
  page: (json['page'] as num?)?.toInt(),
  active: json['active'] as bool,
);

Map<String, dynamic> _$LinkToJson(Link instance) => <String, dynamic>{
  'url': instance.url,
  'label': instance.label,
  'page': instance.page,
  'active': instance.active,
};
