// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_registration_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyRegistrationUser _$MyRegistrationUserFromJson(Map<String, dynamic> json) =>
    MyRegistrationUser(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      telp: json['telp'] as String,
    );

Map<String, dynamic> _$MyRegistrationUserToJson(MyRegistrationUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'telp': instance.telp,
    };
