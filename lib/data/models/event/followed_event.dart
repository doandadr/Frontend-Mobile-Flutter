import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'followed_event.g.dart';

@JsonSerializable()
class FollowedEvent extends Equatable {
  final bool success;
  final String message;
  final Data? data;

  const FollowedEvent({
    required this.success,
    required this.message,
    this.data,
  });

  factory FollowedEvent.fromJson(Map<String, dynamic> json) =>
      _$FollowedEventFromJson(json);

  Map<String, dynamic> toJson() => _$FollowedEventToJson(this);

  @override
  List<Object?> get props => [success, message, data];
}

@JsonSerializable()
class Data extends Equatable {
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

  const Data({
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
  final int id;

  @JsonKey(name: 'modul_acara_id')
  final int modulAcaraId;

  @JsonKey(name: 'user_id')
  final int userId;

  @JsonKey(name: 'metode_daftar')
  final String metodeDaftar;

  @JsonKey(name: 'waktu_daftar')
  final DateTime? waktuDaftar;

  @JsonKey(name: 'has_doorprize')
  final int hasDoorprize;

  @JsonKey(name: 'tipe_kehadiran')
  final String? tipeKehadiran;

  @JsonKey(name: 'no_sertifikat')
  final dynamic noSertifikat;

  @JsonKey(name: 'modul_acara')
  final ModulAcara? modulAcara;

  String? certificateUrl; //Ini tambahan untuk nyimpen, di API ga ada field ini

  Datum({
    required this.id,
    required this.modulAcaraId,
    required this.userId,
    required this.metodeDaftar,
    this.waktuDaftar,
    required this.hasDoorprize,
    this.tipeKehadiran,
    this.noSertifikat,
    this.modulAcara,
    this.certificateUrl
  });

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
    tipeKehadiran,
    modulAcara,
  ];
}

@JsonSerializable()
class ModulAcara extends Equatable {
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

  @JsonKey(name: 'mdl_acara_mulai')
  final DateTime mdlAcaraMulai;

  // bisa null
  @JsonKey(name: 'mdl_acara_selesai')
  final DateTime? mdlAcaraSelesai;

  @JsonKey(name: 'mdl_status')
  final String mdlStatus;

  @JsonKey(name: 'mdl_banner_acara')
  final String? mdlBannerAcara;

  @JsonKey(name: 'mdl_kode_qr')
  final String? mdlKodeQr;

  @JsonKey(name: 'mdl_file_acara')
  final String? mdlFileAcara;

  @JsonKey(name: 'mdl_file_rundown')
  final String? mdlFileRundown;

  @JsonKey(name: 'mdl_template_sertifikat')
  final String? mdlTemplateSertifikat;

  @JsonKey(name: 'mdl_link_wa')
  final String? mdlLinkWa;

  @JsonKey(name: 'mdl_doorprize_aktif')
  final int mdlDoorprizeAktif;

  @JsonKey(name: 'mdl_sesi_acara')
  final int? mdlSesiAcara;

  @JsonKey(name: 'mdl_banner_acara_url')
  final String? mdlBannerAcaraUrl;

  @JsonKey(name: 'mdl_file_acara_url')
  final String? mdlFileAcaraUrl;

  @JsonKey(name: 'mdl_file_rundown_url')
  final String? mdlFileRundownUrl;

  @JsonKey(name: 'mdl_template_sertifikat_url')
  final String? mdlTemplateSertifikatUrl;

  final List<List<Presensi>>? presensi;

  @JsonKey(name: 'total_hari')
  final int? totalHari;

  @JsonKey(name: 'total_sesi')
  final int? totalSesi;

  const ModulAcara({
    required this.id,
    required this.mdlKode,
    required this.mdlSlug,
    required this.mdlNama,
    required this.mdlKategori,
    required this.mdlTipe,
    this.mdlLokasi,
    required this.mdlAcaraMulai,
    this.mdlAcaraSelesai,
    required this.mdlStatus,
    this.mdlBannerAcara,
    this.mdlKodeQr,
    this.mdlFileAcara,
    this.mdlFileRundown,
    this.mdlTemplateSertifikat,
    this.mdlLinkWa,
    required this.mdlDoorprizeAktif,
    this.mdlSesiAcara,
    this.mdlBannerAcaraUrl,
    this.mdlFileAcaraUrl,
    this.mdlFileRundownUrl,
    this.mdlTemplateSertifikatUrl,
    this.presensi,
    this.totalHari,
    this.totalSesi,
  });

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
    mdlBannerAcara,
    mdlKodeQr,
    mdlFileAcara,
    mdlFileRundown,
    mdlTemplateSertifikat,
    mdlLinkWa,
    mdlDoorprizeAktif,
    mdlSesiAcara,
    mdlBannerAcaraUrl,
    mdlFileAcaraUrl,
    mdlFileRundownUrl,
    mdlTemplateSertifikatUrl,
    presensi,
    totalHari,
    totalSesi,
  ];
}

@JsonSerializable()
class Presensi extends Equatable {
  @JsonKey(name: 'hari_ke')
  final int hariKe;

  @JsonKey(name: 'sesi_acara')
  final int sesiAcara;

  final String status;

  @JsonKey(name: 'tanggal_sesi')
  final DateTime tanggalSesi;

  const Presensi({
    required this.hariKe,
    required this.sesiAcara,
    required this.status,
    required this.tanggalSesi,
  });

  factory Presensi.fromJson(Map<String, dynamic> json) =>
      _$PresensiFromJson(json);

  Map<String, dynamic> toJson() => _$PresensiToJson(this);

  @override
  List<Object?> get props => [hariKe, sesiAcara, status, tanggalSesi];
}

@JsonSerializable()
class Link extends Equatable {
  final String? url;
  final String label;
  final int? page;
  final bool active;

  const Link({
    this.url,
    required this.label,
    this.page,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);

  Map<String, dynamic> toJson() => _$LinkToJson(this);

  @override
  List<Object?> get props => [url, label, page, active];
}
