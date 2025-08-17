import 'package:tokona/packages/packages.dart';

class GetCurrentMerchant {
  final MerchantRepository merchantRepository;

  GetCurrentMerchant(
    this.merchantRepository,
  );

  Future<Either<Failure, Merchant>> get(
    String? search,
    int? page,
    int? limit,
  ) {
    return merchantRepository.getCurrentMerchant(
      search,
      page,
      limit,
    );
  }
}
