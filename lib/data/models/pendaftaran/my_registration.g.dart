// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_registration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyRegistration _$MyRegistrationFromJson(Map<String, dynamic> json) =>
    MyRegistration(
      id: (json['id'] as num).toInt(),
      modulAcaraId: (json['modul_acara_id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      metodeDaftar: json['metode_daftar'] as String,
      waktuDaftar: DateTime.parse(json['waktu_daftar'] as String),
      hasDoorprize: (json['has_doorprize'] as num).toInt(),
      noSertifikat: json['no_sertifikat'] as String?,
      presensi: json['presensi'] == null
          ? null
          : MyRegistrationPresensi.fromJson(
              json['presensi'] as Map<String, dynamic>,
            ),
      modulAcara: MyRegistrationEvent.fromJson(
        json['modul_acara'] as Map<String, dynamic>,
      ),
      user: json['user'] == null
          ? null
          : MyRegistrationUser.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MyRegistrationToJson(MyRegistration instance) =>
    <String, dynamic>{
      'id': instance.id,
      'modul_acara_id': instance.modulAcaraId,
      'user_id': instance.userId,
      'metode_daftar': instance.metodeDaftar,
      'waktu_daftar': instance.waktuDaftar.toIso8601String(),
      'has_doorprize': instance.hasDoorprize,
      'no_sertifikat': instance.noSertifikat,
      'presensi': instance.presensi,
      'modul_acara': instance.modulAcara,
      'user': instance.user,
    };
