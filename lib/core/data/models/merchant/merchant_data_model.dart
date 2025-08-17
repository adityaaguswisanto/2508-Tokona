import 'package:tokona/packages/packages.dart';

class MerchantDataModel extends Equatable {
  final int? id;
  final String? code;
  final String? name;
  final String? address;
  final String? createdAt;
  final String? updatedAt;

  const MerchantDataModel({
    required this.id,
    required this.code,
    required this.name,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MerchantDataModel.fromJson(Map<String, dynamic> json) {
    return MerchantDataModel(
      id: json["id"],
      code: json["code"],
      name: json["name"],
      address: json["address"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "name": name,
    "address": address,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };

  MerchantData toEntity() => MerchantData(
    id: id,
    code: code,
    name: name,
    address: address,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

  @override
  List<Object?> get props => [
    id,
    code,
    name,
    address,
    createdAt,
    updatedAt,
  ];
}
