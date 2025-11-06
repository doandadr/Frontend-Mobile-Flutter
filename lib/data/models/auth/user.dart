import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  final int id;
  final String name;
  final String username;
  final String email;
  final String telp;
  final String role;

  const User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.telp,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [
    id,
    name,
    username,
    email,
    telp,
    role,
  ];
}
