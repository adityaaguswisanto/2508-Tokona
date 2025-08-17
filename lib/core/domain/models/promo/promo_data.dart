import 'package:tokona/packages/packages.dart';

class PromoData extends Equatable {
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

  const PromoData({
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
