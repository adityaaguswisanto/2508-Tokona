import 'package:tokona/packages/packages.dart';

class InventoryArgument extends Equatable {
  final MerchantData? merchantData;

  const InventoryArgument({
    required this.merchantData,
  });

  @override
  List<Object?> get props => [
    merchantData,
  ];
}
