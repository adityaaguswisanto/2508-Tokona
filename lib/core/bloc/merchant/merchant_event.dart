import 'package:tokona/packages/packages.dart';

sealed class MerchantEvent extends Equatable {
  const MerchantEvent();

  @override
  List<Object?> get props => [];
}

class MerchantGetted extends MerchantEvent {
  final String? search;

  const MerchantGetted({
    required this.search,
  });

  @override
  List<Object?> get props => [
    search,
  ];
}

class MerchantRefreshed extends MerchantEvent {
  final String? search;

  const MerchantRefreshed({
    required this.search,
  });

  @override
  List<Object?> get props => [
    search,
  ];
}
