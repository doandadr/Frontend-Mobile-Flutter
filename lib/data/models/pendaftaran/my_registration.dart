import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'my_registration_event.dart';
import 'my_registration_presensi.dart';
import 'my_registration_user.dart';

part 'my_registration.g.dart';

@JsonSerializable()
class MyRegistration extends Equatable {
  final int id;

  @JsonKey(name: 'modul_acara_id')
  final int modulAcaraId;

  @JsonKey(name: 'user_id')
  final int userId;

  @JsonKey(name: 'metode_daftar')
  final String metodeDaftar;

  @JsonKey(name: 'waktu_daftar')
  final DateTime waktuDaftar;

  @JsonKey(name: 'has_doorprize')
  final int hasDoorprize;

  @JsonKey(name: 'no_sertifikat')
  final String? noSertifikat;

  @JsonKey(name: 'presensi')
  final MyRegistrationPresensi?  presensi;

  @JsonKey(name: 'modul_acara')
  final MyRegistrationEvent modulAcara;

  @JsonKey(name: 'user')
  final MyRegistrationUser?  user;

  const MyRegistration({
    required this.id,
    required this.modulAcaraId,
    required this.userId,
    required this.metodeDaftar,
    required this.waktuDaftar,
    required this.hasDoorprize,
    this.noSertifikat,
    this.presensi,
    required this.modulAcara,
    this.user,
  });

  factory MyRegistration.fromJson(Map<String, dynamic> json) =>
      _$MyRegistrationFromJson(json);

  Map<String, dynamic> toJson() => _$MyRegistrationToJson(this);

  @override
  List<Object?> get props => [
    id,
    modulAcaraId,
    userId,
    metodeDaftar,
    waktuDaftar,
    hasDoorprize,
    noSertifikat,
    presensi,
    modulAcara,
    user,
  ];
}
