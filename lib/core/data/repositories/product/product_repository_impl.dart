import 'package:tokona/packages/packages.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteSource productRemoteSource;
  final ProductLocalSource productLocalSource;

  const ProductRepositoryImpl({
    required this.productRemoteSource,
    required this.productLocalSource,
  });

  @override
  Future<Either<Failure, Product>> getCurrentProduct(
    int? merchantId,
    String? search,
    int? page,
    int? limit,
  ) async {
    try {
      final hasInternet = await Internets().c();
      final result = hasInternet
          ? await productRemoteSource.getCurrentProduct(
              merchantId,
              search,
              page,
              limit,
            )
          : await productLocalSource.getCurrentProduct(
              merchantId,
            );

      if (hasInternet) {
        await productLocalSource.postCurrentProduct(
          result,
        );
      }
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          e.error.toString(),
          e.statusCode,
        ),
      );
    } on SocketException {
      return const Left(
        ConnectionFailure(
          ConstantsVariables.responseNoInternet,
          500,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, String>> putCurrentProduct(
    int? id,
    int? available,
  ) async {
    try {
      final result = await productRemoteSource.putCurrentProduct(
        id,
        available,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          e.error.toString(),
          e.statusCode,
        ),
      );
    } on SocketException {
      return const Left(
        ConnectionFailure(
          ConstantsVariables.responseNoInternet,
          500,
        ),
      );
    }
  }
}
