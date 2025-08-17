import 'package:tokona/packages/packages.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class ProductPutted extends ProductEvent {
  final int? id;
  final int? available;

  const ProductPutted({
    required this.id,
    required this.available,
  });

  @override
  List<Object?> get props => [
    id,
    available,
  ];
}

class ProductGetted extends ProductEvent {
  final int? merchantId;
  final String? search;

  const ProductGetted({
    required this.merchantId,
    required this.search,
  });

  @override
  List<Object?> get props => [
    merchantId,
    search,
  ];
}

class ProductRefreshed extends ProductEvent {
  final int? merchantId;
  final String? search;

  const ProductRefreshed({
    required this.merchantId,
    required this.search,
  });

  @override
  List<Object?> get props => [
    merchantId,
    search,
  ];
}
