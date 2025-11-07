// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    RegisterRequest(
      name: json['name'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      telp: json['telp'] as String,
      password: json['password'] as String,
      passwordConfirmation: json['password_confirmation'] as String,
      statusKaryawan: json['status_karyawan'] as String,
    );

Map<String, dynamic> _$RegisterRequestToJson(RegisterRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'username': instance.username,
      'email': instance.email,
      'telp': instance.telp,
      'password': instance.password,
      'password_confirmation': instance.passwordConfirmation,
      'status_karyawan': instance.statusKaryawan,
    };
