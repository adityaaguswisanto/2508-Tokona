import 'package:tokona/packages/packages.dart';

export 'merchant_data.dart';

class Merchant extends Equatable {
  final String? message;
  final List<MerchantData>? data;

  const Merchant({
    required this.message,
    required this.data,
  });

  @override
  List<Object?> get props => [
    message,
    data,
  ];
}
