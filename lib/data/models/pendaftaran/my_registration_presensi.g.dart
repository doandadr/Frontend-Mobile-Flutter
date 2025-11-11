// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_registration_presensi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyRegistrationPresensi _$MyRegistrationPresensiFromJson(
  Map<String, dynamic> json,
) => MyRegistrationPresensi(
  id: (json['id'] as num).toInt(),
  pendaftaranAcaraId: (json['pendaftaran_acara_id'] as num).toInt(),
  modulAcaraId: (json['modul_acara_id'] as num).toInt(),
  userId: (json['user_id'] as num).toInt(),
  waktuAbsen: DateTime.parse(json['waktu_absen'] as String),
  status: json['status'] as String,
  latitude: json['latitude'] as String?,
  longitude: json['longitude'] as String?,
);

Map<String, dynamic> _$MyRegistrationPresensiToJson(
  MyRegistrationPresensi instance,
) => <String, dynamic>{
  'id': instance.id,
  'pendaftaran_acara_id': instance.pendaftaranAcaraId,
  'modul_acara_id': instance.modulAcaraId,
  'user_id': instance.userId,
  'waktu_absen': instance.waktuAbsen.toIso8601String(),
  'status': instance.status,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
};
