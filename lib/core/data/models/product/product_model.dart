import 'package:tokona/packages/packages.dart';

class ProductModel extends Equatable {
  final String? message;
  final List<ProductDataModel>? data;

  const ProductModel({
    required this.message,
    required this.data,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      message: json["message"],
      data: List<ProductDataModel>.from(
        json["data"].map(
          (x) => ProductDataModel.fromJson(x),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data,
  };

  Product toEntity() => Product(
    message: message,
    data: data!
        .map(
          (e) => ProductData(
            id: e.id,
            code: e.code,
            photo: e.photo,
            name: e.name,
            description: e.description,
            price: e.price,
            available: e.available,
            productId: e.productId,
            merchantId: e.merchantId,
            createdAt: e.createdAt,
            updatedAt: e.updatedAt,
          ),
        )
        .toList(),
  );

  @override
  List<Object?> get props => [
    data,
  ];
}
