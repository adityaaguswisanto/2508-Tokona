import 'package:tokona/packages/packages.dart';

sealed class PromoEvent extends Equatable {
  const PromoEvent();

  @override
  List<Object?> get props => [];
}

class PromoSubmitted extends PromoEvent {
  final int? merchantId;
  final int? productId;
  final int? price;
  final int? discount;
  final String? endDate;

  const PromoSubmitted({
    required this.merchantId,
    required this.productId,
    required this.price,
    required this.discount,
    required this.endDate,
  });

  @override
  List<Object?> get props => [
    merchantId,
    productId,
    price,
    discount,
    endDate,
  ];
}

class PromoGetted extends PromoEvent {
  final int? merchantId;
  final String? search;

  const PromoGetted({
    required this.merchantId,
    required this.search,
  });

  @override
  List<Object?> get props => [
    merchantId,
    search,
  ];
}

class PromoRefreshed extends PromoEvent {
  final int? merchantId;
  final String? search;

  const PromoRefreshed({
    required this.merchantId,
    required this.search,
  });

  @override
  List<Object?> get props => [
    merchantId,
    search,
  ];
}
