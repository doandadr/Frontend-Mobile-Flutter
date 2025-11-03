// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cert_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CertResponse _$CertResponseFromJson(Map<String, dynamic> json) => CertResponse(
  status: json['status'] as bool,
  message: json['message'] as String,
  data: json['data'] == null
      ? null
      : Data.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CertResponseToJson(CertResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
  idAcara: (json['id_acara'] as num).toInt(),
  namaAcara: json['nama_acara'] as String,
  tanggalAcara: json['tanggal_acara'] == null
      ? null
      : DateTime.parse(json['tanggal_acara'] as String),
  namaPeserta: json['nama_peserta'] as String,
  noSertifikat: json['no_sertifikat'] as String,
  baseTemplateSertifikat: json['base_template_sertifikat'] as String,
);

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
  'id_acara': instance.idAcara,
  'nama_acara': instance.namaAcara,
  'tanggal_acara': instance.tanggalAcara?.toIso8601String(),
  'nama_peserta': instance.namaPeserta,
  'no_sertifikat': instance.noSertifikat,
  'base_template_sertifikat': instance.baseTemplateSertifikat,
};
