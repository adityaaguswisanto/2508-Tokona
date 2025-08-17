import 'package:tokona/packages/packages.dart';

abstract class PromoRepository {
  Future<Either<Failure, Promo>> getCurrentPromo(
    int? merchantId,
    String? search,
    int? page,
    int? limit,
  );

  Future<Either<Failure, String>> postCurrentPromo(
    int? merchantId,
    int? productId,
    int? price,
    int? discount,
    String? endDate,
  );
}
