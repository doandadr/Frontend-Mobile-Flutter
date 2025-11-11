import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../pendaftaran/my_registration_presensi.dart';
import '../pendaftaran/my_registration_user.dart';

part 'followed_event.g.dart';

@JsonSerializable()
class FollowedEvent extends Equatable {
  FollowedEvent({required this.success, required this.message, this.data});

  final bool success;
  final String message;
  final Data? data;

  factory FollowedEvent.fromJson(Map<String, dynamic> json) =>
      _$FollowedEventFromJson(json);

  Map<String, dynamic> toJson() => _$FollowedEventToJson(this);

  @override
  List<Object?> get props => [success, message, data];
}

@JsonSerializable()
class Data extends Equatable {
  Data({
    required this.currentPage,
    this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
    required this.total,
  });

  @JsonKey(name: 'current_page')
  final int currentPage;

  final List<Datum>? data;

  @JsonKey(name: 'first_page_url')
  final String firstPageUrl;

  final int from;

  @JsonKey(name: 'last_page')
  final int lastPage;

  @JsonKey(name: 'last_page_url')
  final String lastPageUrl;

  final List<Link>? links;

  // bisa null di halaman terakhir
  @JsonKey(name: 'next_page_url')
  final String? nextPageUrl;

  final String path;

  @JsonKey(name: 'per_page')
  final int perPage;

  // null di halaman pertama
  @JsonKey(name: 'prev_page_url')
  final String? prevPageUrl;

  final int to;
  final int total;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);

  @override
  List<Object?> get props => [
    currentPage,
    data,
    firstPageUrl,
    from,
    lastPage,
    lastPageUrl,
    links,
    nextPageUrl,
    path,
    perPage,
    prevPageUrl,
    to,
    total,
  ];
}

@JsonSerializable()
class Datum extends Equatable {
  Datum({
    required this.id,
    required this.modulAcaraId,
    required this.userId,
    required this.metodeDaftar,
    this.waktuDaftar,
    required this.hasDoorprize,
    this.noSertifikat,
    this.createdAt,
    this.updatedAt,
    this.modulAcara,
    this.presensi,
    this.user,
  });

  final int id;

  @JsonKey(name: 'modul_acara_id')
  final int modulAcaraId;

  @JsonKey(name: 'user_id')
  final int userId;

  @JsonKey(name: 'metode_daftar')
  final String metodeDaftar;

  // CATATAN: format bukan ISO; kalau error parsing, ubah ke String? atau pakai converter
  @JsonKey(name: 'waktu_daftar')
  final DateTime? waktuDaftar;

  @JsonKey(name: 'has_doorprize')
  final int hasDoorprize;

  @JsonKey(name: 'no_sertifikat')
  final dynamic noSertifikat;

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @JsonKey(name: 'modul_acara')
  final ModulAcara? modulAcara;

  @JsonKey(name: 'presensi')
  final MyRegistrationPresensi?  presensi;

  @JsonKey(name: 'user')
  final MyRegistrationUser?  user;

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);

  @override
  List<Object?> get props => [
    id,
    modulAcaraId,
    userId,
    metodeDaftar,
    waktuDaftar,
    hasDoorprize,
    noSertifikat,
    createdAt,
    updatedAt,
    modulAcara,
  ];
}

@JsonSerializable()
class ModulAcara extends Equatable {
  ModulAcara({
    required this.id,
    required this.mdlKode,
    required this.mdlSlug,
    required this.mdlNama,
    required this.mdlKategori,
    required this.mdlTipe,
    this.mdlLokasi,
    this.mdlAcaraMulai,
    this.mdlAcaraSelesai,
    required this.mdlStatus,
    this.mdlKodeQr,
    this.mdlBannerAcaraUrl,
    this.mdlFileAcaraUrl,
    this.mdlFileRundownUrl,
    this.mdlTemplateSertifikatUrl
  });

  final int id;

  @JsonKey(name: 'mdl_kode')
  final String mdlKode;

  @JsonKey(name: 'mdl_slug')
  final String mdlSlug;

  @JsonKey(name: 'mdl_nama')
  final String mdlNama;

  @JsonKey(name: 'mdl_kategori')
  final String mdlKategori;

  @JsonKey(name: 'mdl_tipe')
  final String mdlTipe;

  // bisa null
  @JsonKey(name: 'mdl_lokasi')
  final String? mdlLokasi;

  // CATATAN: format bukan ISO; kalau error parsing, ubah ke String? atau pakai converter
  @JsonKey(name: 'mdl_acara_mulai')
  final DateTime? mdlAcaraMulai;

  // bisa null
  @JsonKey(name: 'mdl_acara_selesai')
  final DateTime? mdlAcaraSelesai;

  @JsonKey(name: 'mdl_status')
  final String mdlStatus;

  // bisa null
  @JsonKey(name: 'mdl_kode_qr')
  final String? mdlKodeQr;

  // bisa null
  @JsonKey(name: 'mdl_banner_acara_url')
  final String? mdlBannerAcaraUrl;

  // bisa null
  @JsonKey(name: 'mdl_file_acara_url')
  final String? mdlFileAcaraUrl;

  // bisa null
  @JsonKey(name: 'mdl_file_rundown_url')
  final String? mdlFileRundownUrl;

  @JsonKey(name: "mdl_template_sertifikat_url")
  final String? mdlTemplateSertifikatUrl;

  factory ModulAcara.fromJson(Map<String, dynamic> json) =>
      _$ModulAcaraFromJson(json);

  Map<String, dynamic> toJson() => _$ModulAcaraToJson(this);

  @override
  List<Object?> get props => [
    id,
    mdlKode,
    mdlSlug,
    mdlNama,
    mdlKategori,
    mdlTipe,
    mdlLokasi,
    mdlAcaraMulai,
    mdlAcaraSelesai,
    mdlStatus,
    mdlKodeQr,
    mdlBannerAcaraUrl,
    mdlFileAcaraUrl,
    mdlFileRundownUrl,
    mdlTemplateSertifikatUrl
  ];
}

@JsonSerializable()
class Link extends Equatable {
  Link({this.url, required this.label, this.page, required this.active});

  // bisa null pada item «Previous»
  final String? url;

  final String label;

  // bisa null pada item «Previous»
  final int? page;

  final bool active;

  factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);

  Map<String, dynamic> toJson() => _$LinkToJson(this);

  @override
  List<Object?> get props => [url, label, page, active];
}