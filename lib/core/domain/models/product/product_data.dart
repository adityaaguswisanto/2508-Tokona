import 'package:tokona/packages/packages.dart';

class ProductData extends Equatable {
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

  const ProductData({
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
