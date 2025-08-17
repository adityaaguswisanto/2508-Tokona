import 'package:tokona/packages/packages.dart';

abstract class ProductRepository {
  Future<Either<Failure, Product>> getCurrentProduct(
    int? merchantId,
    String? search,
    int? page,
    int? limit,
  );

  Future<Either<Failure, String>> putCurrentProduct(
    int? id,
    int? available,
  );
}
