import 'package:tokona/packages/packages.dart';

abstract class MerchantRepository {
  Future<Either<Failure, Merchant>> getCurrentMerchant(
    String? search,
    int? page,
    int? limit,
  );
}
