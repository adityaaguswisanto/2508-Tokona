import 'package:tokona/packages/packages.dart';

class MerchantData extends Equatable {
  final int? id;
  final String? code;
  final String? name;
  final String? address;
  final String? createdAt;
  final String? updatedAt;

  const MerchantData({
    required this.id,
    required this.code,
    required this.name,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
  });

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
