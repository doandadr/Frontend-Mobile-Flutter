import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable()
class Event extends Equatable {
  final int id;

  @JsonKey(name: 'user_id')
  final int? userId;

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
  final String pendaftaranMulai;

  @JsonKey(name: 'mdl_pendaftaran_selesai')
  final String pendaftaranSelesai;

  @JsonKey(name: 'mdl_maks_peserta_eksternal')
  final int? maksPesertaEksternal;

  @JsonKey(name: 'mdl_acara_mulai')
  final String acaraMulai;

  @JsonKey(name: 'mdl_acara_selesai')
  final String? acaraSelesai;

  @JsonKey(name: 'mdl_status')
  final String status;

  @JsonKey(name: 'is_public')
  final int isPublic;

  @JsonKey(name: 'media_urls')
  final MediaUrls? mediaUrls;

  const Event({
    required this.id,
    this.userId,
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
    this.mediaUrls,
  });

  factory Event.fromJson(Map<String, dynamic> json) =>
      _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);

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
        mediaUrls,
      ];
}

@JsonSerializable()
class MediaUrls extends Equatable {
  final String? banner;

  const MediaUrls({this.banner});

  factory MediaUrls.fromJson(Map<String, dynamic> json) =>
      _$MediaUrlsFromJson(json);

  Map<String, dynamic> toJson() => _$MediaUrlsToJson(this);

  @override
  List<Object?> get props => [banner];
}
