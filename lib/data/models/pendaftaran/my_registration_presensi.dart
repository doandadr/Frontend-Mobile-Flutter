import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'my_registration_presensi.g.dart';

@JsonSerializable()
class MyRegistrationPresensi extends Equatable {
  final int id;

  @JsonKey(name: 'pendaftaran_acara_id')
  final int pendaftaranAcaraId;

  @JsonKey(name: 'modul_acara_id')
  final int modulAcaraId;

  @JsonKey(name: 'user_id')
  final int userId;

  @JsonKey(name: 'waktu_absen')
  final DateTime waktuAbsen;

  final String status;
  final String? latitude;
  final String? longitude;

  const MyRegistrationPresensi({
    required this.id,
    required this.pendaftaranAcaraId,
    required this.modulAcaraId,
    required this.userId,
    required this.waktuAbsen,
    required this.status,
    this.latitude,
    this.longitude,X
  });

  factory MyRegistrationPresensi.fromJson(Map<String, dynamic> json) =>
      _$MyRegistrationPresensiFromJson(json);

  Map<String, dynamic> toJson() =>
      _$MyRegistrationPresensiToJson(this);

  @override
  List<Object?> get props => [id, status, waktuAbsen];
}
