import 'package:tokona/packages/packages.dart';

class GetCurrentProduct {
  final ProductRepository productRepository;

  GetCurrentProduct(
    this.productRepository,
  );

  Future<Either<Failure, Product>> get(
    int? merchantId,
    String? search,
    int? page,
    int? limit,
  ) {
    return productRepository.getCurrentProduct(
      merchantId,
      search,
      page,
      limit,
    );
  }

  Future<Either<Failure, String>> put(
    int? id,
    int? available,
  ) {
    return productRepository.putCurrentProduct(
      id,
      available,
    );
  }
}
