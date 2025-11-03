// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  username: json['username'] as String,
  email: json['email'] as String,
  telp: json['telp'] as String,
  role: json['role'] as String,
  statusKaryawan: (json['status_karyawan'] as num).toInt(),
  emailVerifiedAt: json['email_verified_at'] as String?,
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'username': instance.username,
  'email': instance.email,
  'telp': instance.telp,
  'role': instance.role,
  'status_karyawan': instance.statusKaryawan,
  'email_verified_at': instance.emailVerifiedAt,
};
