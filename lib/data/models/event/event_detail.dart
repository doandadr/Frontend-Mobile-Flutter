import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_detail.g.dart';

@JsonSerializable(explicitToJson: true)
class EventDetailResponse extends Equatable {
  final bool success;
  final String message;
  final EventDetail data;

  const EventDetailResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory EventDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$EventDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EventDetailResponseToJson(this);

  @override
  List<Object?> get props => [success, message, data];
}

@JsonSerializable()
class EventDetail extends Equatable {
  final int id;

  @JsonKey(name: "user_id")
  final int userId;

  @JsonKey(name: "mdl_kode")
  final String kode;

  @JsonKey(name: "mdl_slug")
  final String slug;

  @JsonKey(name: "mdl_nama")
  final String nama;

  @JsonKey(name: "mdl_deskripsi")
  final String deskripsi;

  @JsonKey(name: "mdl_tipe")
  final String tipe;

  @JsonKey(name: "mdl_kategori")
  final String kategori;

  @JsonKey(name: "mdl_lokasi")
  final String? lokasi;

  @JsonKey(name: "mdl_latitude")
  final String? latitude;

  @JsonKey(name: "mdl_longitude")
  final String? longitude;

  @JsonKey(name: "mdl_radius")
  final int? radius;

  @JsonKey(name: "mdl_pendaftaran_mulai")
  final DateTime pendaftaranMulai;

  @JsonKey(name: "mdl_pendaftaran_selesai")
  final DateTime pendaftaranSelesai;

  @JsonKey(name: "mdl_maks_peserta_eksternal")
  final int? maksPesertaEksternal;

  @JsonKey(name: "mdl_acara_mulai")
  final DateTime acaraMulai;

  @JsonKey(name: "mdl_acara_selesai")
  final DateTime? acaraSelesai;

  @JsonKey(name: "mdl_status")
  final String status;

  @JsonKey(name: "is_public")
  final int isPublic;

  @JsonKey(name: "mdl_presensi_aktif")
  final int presensiAktif;

  @JsonKey(name: "mdl_kode_qr")
  final String? kodeQr;

  @JsonKey(name: "mdl_link_wa")
  final String? linkWa;

  @JsonKey(name: "mdl_file_acara")
  final String? fileAcara;

  @JsonKey(name: "mdl_file_rundown")
  final String? fileRundown;

  @JsonKey(name: "mdl_template_sertifikat")
  final String? templateSertifikat;

  @JsonKey(name: "mdl_sertifikat_aktif")
  final int sertifikatAktif;

  @JsonKey(name: "mdl_doorprize_aktif")
  final int doorprizeAktif;

  @JsonKey(name: "mdl_banner_acara")
  final String? bannerAcara;

  @JsonKey(name: "mdl_catatan")
  final String? catatan;

  // @JsonKey(name: "created_by")
  // final int createdBy;

  // @JsonKey(name: "updated_by")
  // final int? updatedBy;

  // @JsonKey(name: "created_at")
  // final String? createdAt;

  // @JsonKey(name: "updated_at")
  // final String? updatedAt;

  // @JsonKey(name: "deleted_at")
  // final String? deletedAt;

  const EventDetail({
    required this.id,
    required this.userId,
    required this.kode,
    required this.slug,
    required this.nama,
    required this.deskripsi,
    required this.tipe,
    required this.kategori,
    this.lokasi,
    this.latitude,
    this.longitude,
    this.radius,
    required this.pendaftaranMulai,
    required this.pendaftaranSelesai,
    this.maksPesertaEksternal,
    required this.acaraMulai,
    this.acaraSelesai,
    required this.status,
    required this.isPublic,
    required this.presensiAktif,
    this.kodeQr,
    this.linkWa,
    this.fileAcara,
    this.fileRundown,
    this.templateSertifikat,
    required this.sertifikatAktif,
    required this.doorprizeAktif,
    this.bannerAcara,
    this.catatan,
    // required this.createdBy,
    // this.updatedBy,
    // this.createdAt,
    // this.updatedAt,
    // this.deletedAt,
  });

  factory EventDetail.fromJson(Map<String, dynamic> json) =>
      _$EventDetailFromJson(json);

  Map<String, dynamic> toJson() => _$EventDetailToJson(this);

  @override
  List<Object?> get props => [
    id,
    userId,
    kode,
    slug,
    nama,
    deskripsi,
    tipe,
    kategori,
    lokasi,
    latitude,
    longitude,
    radius,
    pendaftaranMulai,
    pendaftaranSelesai,
    maksPesertaEksternal,
    acaraMulai,
    acaraSelesai,
    status,
    isPublic,
    presensiAktif,
    kodeQr,
    linkWa,
    fileAcara,
    fileRundown,
    templateSertifikat,
    sertifikatAktif,
    doorprizeAktif,
    bannerAcara,
    catatan,
    // createdBy,
    // updatedBy,
    // createdAt,
    // updatedAt,
    // deletedAt,
  ];
}
