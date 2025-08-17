import 'package:tokona/packages/packages.dart';

class ProductDataModel extends Equatable {
  final int? id;
  final String? code;
  final String? photo;
  final String? name;
  final String? description;
  final int? price;
  final int? available;
  final int? productId;
  final int? merchantId;
  final String? createdAt;
  final String? updatedAt;

  const ProductDataModel({
    required this.id,
    required this.code,
    required this.photo,
    required this.name,
    required this.description,
    required this.price,
    required this.available,
    required this.productId,
    required this.merchantId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductDataModel.fromJson(Map<String, dynamic> json) {
    return ProductDataModel(
      id: json["id"],
      code: json["code"],
      photo: json["photo"],
      name: json["name"],
      description: json["description"],
      price: json["price"],
      available: json["available"],
      productId: json["productId"],
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
    "available": available,
    "productId": productId,
    "merchantId": merchantId,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };

  ProductData toEntity() => ProductData(
    id: id,
    code: code,
    photo: photo,
    name: name,
    description: description,
    price: price,
    available: available,
    productId: productId,
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
    available,
    productId,
    merchantId,
    createdAt,
    updatedAt,
  ];
}
