import 'package:tokona/packages/packages.dart';

class MerchantRepositoryImpl implements MerchantRepository {
  final MerchantRemoteSource merchantRemoteSource;
  final MerchantLocalSource merchantLocalSource;

  const MerchantRepositoryImpl({
    required this.merchantRemoteSource,
    required this.merchantLocalSource,
  });

  @override
  Future<Either<Failure, Merchant>> getCurrentMerchant(
    String? search,
    int? page,
    int? limit,
  ) async {
    try {
      final hasInternet = await Internets().c();
      final result = hasInternet
          ? await merchantRemoteSource.getCurrentMerchant(search, page, limit)
          : await merchantLocalSource.getCurrentMerchant();
      if (hasInternet) {
        await merchantLocalSource.postCurrentMerchant(result);
      }
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.error.toString(), e.statusCode));
    } on SocketException {
      return const Left(
        ConnectionFailure(ConstantsVariables.responseNoInternet, 500),
      );
    }
  }
}
