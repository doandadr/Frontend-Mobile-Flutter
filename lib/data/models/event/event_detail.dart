// import 'package:equatable/equatable.dart';
// import 'package:json_annotation/json_annotation.dart';
//
// part 'event_detail.g.dart';
//
// @JsonSerializable()
// class EventDetailResponse extends Equatable {
//   EventDetailResponse({
//     required this.success,
//     required this.message,
//     required this.data,
//   });
//
//   final bool success;
//   final String message;
//   final Data? data;
//
//   factory EventDetailResponse.fromJson(Map<String, dynamic> json) => _$EventDetailResponseFromJson(json);
//
//   Map<String, dynamic> toJson() => _$EventDetailResponseToJson(this);
//
//   @override
//   List<Object?> get props => [
//     success, message, data, ];
// }
//
// @JsonSerializable()
// class Data extends Equatable {
//   Data({
//     required this.event,
//   });
//
//   final Event? event;
//
//   factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
//
//   Map<String, dynamic> toJson() => _$DataToJson(this);
//
//   @override
//   List<Object?> get props => [
//     event, ];
// }
//
// @JsonSerializable()
// class Event extends Equatable {
//   Event({
//     required this.id,
//     required this.kode,
//     required this.slug,
//     required this.nama,
//     required this.deskripsi,
//     required this.tipe,
//     required this.statusAcara,
//     required this.lokasi,
//     required this.latitude,
//     required this.longitude,
//     required this.radius,
//     required this.pendaftaran,
//     required this.acara,
//     required this.kapasitas,
//     required this.status,
//     required this.banner,
//     required this.catatan,
//     required this.createdAt,
//   });
//
//   final int id;
//   final String kode;
//   final String slug;
//   final String nama;
//   final String deskripsi;
//   final String tipe;
//
//   @JsonKey(name: 'status_acara')
//   final String statusAcara;
//   final String lokasi;
//   final dynamic latitude;
//   final dynamic longitude;
//   final dynamic radius;
//   final Acara? pendaftaran;
//   final Acara? acara;
//   final Kapasitas? kapasitas;
//   final String status;
//   final String banner;
//   final String catatan;
//
//   @JsonKey(name: 'created_at')
//   final String createdAt;
//
//   factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
//
//   Map<String, dynamic> toJson() => _$EventToJson(this);
//
//   @override
//   List<Object?> get props => [
//     id, kode, slug, nama, deskripsi, tipe, statusAcara, lokasi, latitude, longitude, radius, pendaftaran, acara, kapasitas, status, banner, catatan, createdAt, ];
// }
//
// @JsonSerializable()
// class Acara extends Equatable {
//   Acara({
//     required this.mulai,
//     required this.selesai,
//     required this.mulaiRaw,
//     required this.selesaiRaw,
//     required this.isOpen,
//   });
//
//   final String mulai;
//   final String selesai;
//
//   @JsonKey(name: 'mulai_raw')
//   final DateTime? mulaiRaw;
//
//   @JsonKey(name: 'selesai_raw')
//   final DateTime? selesaiRaw;
//
//   @JsonKey(name: 'is_open')
//   final bool isOpen;
//
//   factory Acara.fromJson(Map<String, dynamic> json) => _$AcaraFromJson(json);
//
//   Map<String, dynamic> toJson() => _$AcaraToJson(this);
//
//   @override
//   List<Object?> get props => [
//     mulai, selesai, mulaiRaw, selesaiRaw, isOpen, ];
// }
//
// @JsonSerializable()
// class Kapasitas extends Equatable {
//   Kapasitas({
//     required this.offline,
//     required this.online,
//   });
//
//   final dynamic offline;
//   final dynamic online;
//
//   factory Kapasitas.fromJson(Map<String, dynamic> json) => _$KapasitasFromJson(json);
//
//   Map<String, dynamic> toJson() => _$KapasitasToJson(this);
//
//   @override
//   List<Object?> get props => [
//     offline, online, ];
// }


import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_detail.g.dart';

@JsonSerializable()
class EventDetailResponse extends Equatable {
  EventDetailResponse({
    required this.success,
    required this.message,
    this.data,
  });

  // kalau mau ekstra aman: @JsonKey(defaultValue: false)
  final bool success;

  // kalau mau ekstra aman: @JsonKey(defaultValue: '')
  final String message;

  final Data? data;

  factory EventDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$EventDetailResponseFromJson(json);
  Map<String, dynamic> toJson() => _$EventDetailResponseToJson(this);

  @override
  List<Object?> get props => [success, message, data];
}

@JsonSerializable()
class Data extends Equatable {
  Data({this.event});

  final Event? event;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);

  @override
  List<Object?> get props => [event];
}

@JsonSerializable()
class Event extends Equatable {
  Event({
    required this.id,
    required this.kode,
    required this.slug,
    required this.nama,
    this.deskripsi = '',
    this.tipe = '',
    this.statusAcara = '',
    this.lokasi = '',
    this.latitude,
    this.longitude,
    this.radius,
    this.pendaftaran,
    this.acara,
    this.kapasitas,
    this.status = '',
    this.banner = '',
    this.catatan = '',
    this.createdAt = '',
  });

  @JsonKey(fromJson: _toInt)
  final int id;

  final String kode;
  final String slug;
  final String nama;

  @JsonKey(defaultValue: '')
  final String deskripsi;

  @JsonKey(defaultValue: '')
  final String tipe;

  @JsonKey(name: 'status_acara', defaultValue: '')
  final String statusAcara;

  @JsonKey(defaultValue: '')
  final String lokasi;

  // Bisa number/null — biarkan dynamic
  final dynamic latitude;
  final dynamic longitude;
  final dynamic radius;

  final Acara? pendaftaran;
  final Acara? acara;
  final Kapasitas? kapasitas;

  @JsonKey(defaultValue: '')
  final String status;

  @JsonKey(defaultValue: '')
  final String banner;

  @JsonKey(defaultValue: '')
  final String catatan;

  @JsonKey(name: 'created_at', defaultValue: '')
  final String createdAt;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
  Map<String, dynamic> toJson() => _$EventToJson(this);

  @override
  List<Object?> get props => [
    id,
    kode,
    slug,
    nama,
    deskripsi,
    tipe,
    statusAcara,
    lokasi,
    latitude,
    longitude,
    radius,
    pendaftaran,
    acara,
    kapasitas,
    status,
    banner,
    catatan,
    createdAt,
  ];

  static int _toInt(dynamic v) =>
      v is int ? v : int.parse(v.toString());
}

@JsonSerializable()
class Acara extends Equatable {
  Acara({
    this.mulai = '',
    this.selesai = '',
    this.mulaiRaw,
    this.selesaiRaw,
    this.isOpen = false,
  });

  @JsonKey(defaultValue: '')
  final String mulai;

  @JsonKey(defaultValue: '')
  final String selesai;

  @JsonKey(name: 'mulai_raw', fromJson: _toDateTimeNullable)
  final DateTime? mulaiRaw;

  @JsonKey(name: 'selesai_raw', fromJson: _toDateTimeNullable)
  final DateTime? selesaiRaw;

  @JsonKey(name: 'is_open', fromJson: _toBool, defaultValue: false)
  final bool isOpen;

  factory Acara.fromJson(Map<String, dynamic> json) => _$AcaraFromJson(json);
  Map<String, dynamic> toJson() => _$AcaraToJson(this);

  @override
  List<Object?> get props => [mulai, selesai, mulaiRaw, selesaiRaw, isOpen];

  static DateTime? _toDateTimeNullable(dynamic v) {
    if (v == null || (v is String && v.isEmpty)) return null;
    if (v is String) return DateTime.tryParse(v);
    return null;
  }

  static bool _toBool(dynamic v) {
    if (v is bool) return v;
    if (v is num) return v != 0;
    if (v is String) {
      final s = v.toLowerCase();
      return s == 'true' || s == '1' || s == 'yes' || s == 'open';
    }
    return false;
  }
}

@JsonSerializable()
class Kapasitas extends Equatable {
  Kapasitas({this.offline, this.online});

  final dynamic offline;
  final dynamic online;

  factory Kapasitas.fromJson(Map<String, dynamic> json) =>
      _$KapasitasFromJson(json);
  Map<String, dynamic> toJson() => _$KapasitasToJson(this);

  @override
  List<Object?> get props => [offline, online];
}
