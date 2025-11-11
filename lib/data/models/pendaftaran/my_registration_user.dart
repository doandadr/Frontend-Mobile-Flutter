import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'my_registration_user.g.dart';

@JsonSerializable()
class MyRegistrationUser extends Equatable {
  final int id;
  final String name;
  final String telp;

  const MyRegistrationUser({
    required this.id,
    required this.name,
    required this.telp,
  });

  factory MyRegistrationUser.fromJson(Map<String, dynamic> json) =>
      _$MyRegistrationUserFromJson(json);

  Map<String, dynamic> toJson() =>
      _$MyRegistrationUserToJson(this);

  @override
  List<Object?> get props => [id, name];
}
