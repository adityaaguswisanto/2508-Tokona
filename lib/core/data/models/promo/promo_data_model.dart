import 'package:tokona/packages/packages.dart';

class PromoDataModel extends Equatable {
  final int? id;
  final String? code;
  final String? photo;
  final String? name;
  final String? description;
  final int? price;
  final int? discount;
  final String? endDate;
  final int? merchantId;
  final String? createdAt;
  final String? updatedAt;

  const PromoDataModel({
    required this.id,
    required this.code,
    required this.photo,
    required this.name,
    required this.description,
    required this.price,
    required this.discount,
    required this.endDate,
    required this.merchantId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PromoDataModel.fromJson(Map<String, dynamic> json) {
    return PromoDataModel(
      id: json["id"],
      code: json["code"],
      photo: json["photo"],
      name: json["name"],
      description: json["description"],
      price: json["price"],
      discount: json["discount"],
      endDate: json["endDate"],
      merchantId: json["merchantId"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "photo": photo,
    "name": name,
    "description": description,
    "price": price,
    "discount": discount,
    "endDate": endDate,
    "merchantId": merchantId,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };

  PromoData toEntity() => PromoData(
    id: id,
    code: code,
    photo: photo,
    name: name,
    description: description,
    price: price,
    discount: discount,
    endDate: endDate,
    merchantId: merchantId,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

  @override
  List<Object?> get props => [
    id,
    code,
    photo,
    name,
    description,
    price,
    discount,
    endDate,
    merchantId,
    createdAt,
    updatedAt,
  ];
}
