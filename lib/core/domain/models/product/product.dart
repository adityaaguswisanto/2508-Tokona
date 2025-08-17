import 'package:tokona/packages/packages.dart';

export 'product_data.dart';

class Product extends Equatable {
  final String? message;
  final List<ProductData>? data;

  const Product({
    required this.message,
    required this.data,
  });

  @override
  List<Object?> get props => [
    message,
    data,
  ];
}
