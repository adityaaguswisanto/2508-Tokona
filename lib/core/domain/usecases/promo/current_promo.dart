import 'package:tokona/packages/packages.dart';

class GetCurrentPromo {
  final PromoRepository promoRepository;

  GetCurrentPromo(
    this.promoRepository,
  );

  Future<Either<Failure, Promo>> get(
    int? merchantId,
    String? search,
    int? page,
    int? limit,
  ) {
    return promoRepository.getCurrentPromo(
      merchantId,
      search,
      page,
      limit,
    );
  }

  Future<Either<Failure, String>> post(
    int? merchantId,
    int? productId,
    int? price,
    int? discount,
    String? endDate,
  ) {
    return promoRepository.postCurrentPromo(
      merchantId,
      productId,
      price,
      discount,
      endDate,
    );
  }
}
