import 'package:tokona/packages/packages.dart';

class LoginDataModel extends Equatable {
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

  const LoginDataModel({
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

  factory LoginDataModel.fromJson(Map<String, dynamic> json) {
    return LoginDataModel(
      id: json["id"],
      nik: json["nik"],
      name: json["name"],
      username: json["username"],
      position: json["position"],
      role: json["role"],
      photo: json["photo"],
      token: json["token"],
      createdAt: json["createdAtt"],
      updatedAt: json["updatedAtt"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "nik": nik,
    "name": name,
    "username": username,
    "position": position,
    "role": role,
    "photo": photo,
    "token": token,
    "createdAtt": createdAt,
    "updatedAtt": updatedAt,
  };

  LoginData toEntity() => LoginData(
    id: id,
    nik: nik,
    name: name,
    username: username,
    position: position,
    role: role,
    photo: photo,
    token: token,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

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
