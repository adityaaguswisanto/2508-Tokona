import 'package:tokona/packages/packages.dart';

abstract class MerchantRemoteSource {
  Future<MerchantModel> getCurrentMerchant(
    String? search,
    int? page,
    int? limit,
  );
}

class MerchantRemoteSourceImpl implements MerchantRemoteSource {
  final Dio dio;

  MerchantRemoteSourceImpl({
    required this.dio,
  });

  @override
  Future<MerchantModel> getCurrentMerchant(
    String? search,
    int? page,
    int? limit,
  ) async {
    try {
      final response = await dio.get(
        "${ConstantsVariables.urlBase}${ConstantsVariables.urlMerchant}",
        queryParameters: {
          "search": search,
          "page": page,
          "limit": limit,
        },
      );
      return MerchantModel.fromJson(response.data);
    } on DioException catch (e) {
      throw exception(e);
    }
  }
}
