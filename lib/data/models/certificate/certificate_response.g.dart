// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certificate_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CertificateResponse _$CertificateResponseFromJson(Map<String, dynamic> json) =>
    CertificateResponse(
      status: json['status'] as bool,
      message: json['message'] as String,
      data: json['data'] as String?,
    );

Map<String, dynamic> _$CertificateResponseToJson(
  CertificateResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};
