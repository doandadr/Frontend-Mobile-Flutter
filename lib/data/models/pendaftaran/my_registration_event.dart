import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'my_registration_event.g.dart';

@JsonSerializable()
class MyRegistrationEvent extends Equatable {
  final int id;

  @JsonKey(name: 'user_id')
  final int userId;

  @JsonKey(name: 'mdl_kode')
  final String kode;

  @JsonKey(name: 'mdl_slug')
  final String slug;

  @JsonKey(name: 'mdl_nama')
  final String nama;

  @JsonKey(name: 'mdl_deskripsi')
  final String deskripsi;

  @JsonKey(name: 'mdl_tipe')
  final String tipe;

  @JsonKey(name: 'mdl_kategori')
  final String kategori;

  @JsonKey(name: 'mdl_lokasi')
  final String? lokasi;

  @JsonKey(name: 'mdl_latitude')
  final String? latitude;

  @JsonKey(name: 'mdl_longitude')
  final String? longitude;

  @JsonKey(name: 'mdl_radius')
  final int? radius;

  @JsonKey(name: 'mdl_pendaftaran_mulai')
  final DateTime pendaftaranMulai;

  @JsonKey(name: 'mdl_pendaftaran_selesai')
  final DateTime pendaftaranSelesai;

  @JsonKey(name: 'mdl_maks_peserta_eksternal')
  final int? maksPesertaEksternal;

  @JsonKey(name: 'mdl_acara_mulai')
  final DateTime acaraMulai;

  @JsonKey(name: 'mdl_acara_selesai')
  final DateTime acaraSelesai;

  @JsonKey(name: 'mdl_status')
  final String status;

  @JsonKey(name: 'is_public')
  final int isPublic;

  @JsonKey(name: 'mdl_presensi_aktif')
  final int presensiAktif;

  @JsonKey(name: 'mdl_kode_qr')
  final String? kodeQr;

  @JsonKey(name: 'mdl_link_wa')
  final String? linkWa;

  @JsonKey(name: 'mdl_sertifikat_aktif')
  final int sertifikatAktif;

  @JsonKey(name: 'mdl_doorprize_aktif')
  final int doorprizeAktif;

  @JsonKey(name: 'mdl_catatan')
  final String? catatan;

  @JsonKey(name: 'mdl_banner_acara_url')
  final String? bannerAcaraUrl;

  @JsonKey(name: 'mdl_file_acara_url')
  final String? fileAcaraUrl;

  @JsonKey(name: 'mdl_file_rundown_url')
  final String? fileRundownUrl;

  @JsonKey(name: 'mdl_template_sertifikat_url')
  final String? templateSertifikatUrl;

  const MyRegistrationEvent({
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
    required this.acaraSelesai,
    required this.status,
    required this.isPublic,
    required this.presensiAktif,
    this.kodeQr,
    this.linkWa,
    required this.sertifikatAktif,
    required this.doorprizeAktif,
    this.catatan,
    this.bannerAcaraUrl,
    this.fileAcaraUrl,
    this.fileRundownUrl,
    this.templateSertifikatUrl,
  });

  factory MyRegistrationEvent.fromJson(Map<String, dynamic> json) =>
      _$MyRegistrationEventFromJson(json);

  Map<String, dynamic> toJson() => _$MyRegistrationEventToJson(this);

  @override
  List<Object?> get props => [
    id,
    kode,
    slug,
    nama,
  ];
}
