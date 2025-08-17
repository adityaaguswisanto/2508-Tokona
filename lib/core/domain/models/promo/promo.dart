import 'package:tokona/packages/packages.dart';

export 'promo_data.dart';

class Promo extends Equatable {
  final String? message;
  final List<PromoData>? data;

  const Promo({
    required this.message,
    required this.data,
  });

  @override
  List<Object?> get props => [
    message,
    data,
  ];
}
