import 'package:tokona/packages/packages.dart';

class LoginData extends Equatable {
  final int? id;
  final int? nik;
  final String? name;
  final String? username;
  final String? position;
  final int? role;
  final String? photo;
  final String? token;
  final String? createdAt;
  final String? updatedAt;

  const LoginData({
    required this.id,
    required this.nik,
    required this.name,
    required this.username,
    required this.position,
    required this.role,
    required this.photo,
    required this.token,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    nik,
    name,
    username,
    position,
    role,
    photo,
    token,
    createdAt,
    updatedAt,
  ];
}
