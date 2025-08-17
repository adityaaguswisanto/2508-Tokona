import 'package:tokona/packages/packages.dart';

class PromoRepositoryImpl implements PromoRepository {
  final PromoRemoteSource promoRemoteSource;
  final PromoLocalSource promoLocalSource;

  const PromoRepositoryImpl({
    required this.promoRemoteSource,
    required this.promoLocalSource,
  });

  @override
  Future<Either<Failure, Promo>> getCurrentPromo(
    int? merchantId,
    String? search,
    int? page,
    int? limit,
  ) async {
    try {
      final hasInternet = await Internets().c();
      final result = hasInternet
          ? await promoRemoteSource.getCurrentPromo(
              merchantId,
              search,
              page,
              limit,
            )
          : await promoLocalSource.getCurrentPromo(
              merchantId,
            );

      if (hasInternet) {
        await promoLocalSource.postCurrentPromo(
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
  Future<Either<Failure, String>> postCurrentPromo(
    int? merchantId,
    int? productId,
    int? price,
    int? discount,
    String? endDate,
  ) async {
    try {
      final result = await promoRemoteSource.postCurrentPromo(
        merchantId,
        productId,
        price,
        discount,
        endDate,
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
