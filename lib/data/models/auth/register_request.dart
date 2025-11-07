import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'register_request.g.dart';

@JsonSerializable()
class RegisterRequest extends Equatable {
  final String name;
  final String username;
  final String email;
  final String telp;
  final String password;
  @JsonKey(name: "password_confirmation")
  final String passwordConfirmation;
  @JsonKey(name: "status_karyawan")
  final String statusKaryawan;

  const RegisterRequest({
    required this.name,
    required this.username,
    required this.email,
    required this.telp,
    required this.password,
    required this.passwordConfirmation,
    required this.statusKaryawan,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);

  @override
  List<Object?> get props => [
    name,
    username,
    email,
    telp,
    password,
    passwordConfirmation,
    statusKaryawan
  ];
}