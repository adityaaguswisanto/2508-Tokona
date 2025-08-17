import 'package:tokona/packages/packages.dart';

abstract class PromoRemoteSource {
  Future<PromoModel> getCurrentPromo(
    int? merchantId,
    String? search,
    int? page,
    int? limit,
  );

  Future<String> postCurrentPromo(
    int? merchantId,
    int? productId,
    int? price,
    int? discount,
    String? endDate,
  );
}

class PromoRemoteSourceImpl implements PromoRemoteSource {
  final Dio dio;

  PromoRemoteSourceImpl({
    required this.dio,
  });

  @override
  Future<PromoModel> getCurrentPromo(
    int? merchantId,
    String? search,
    int? page,
    int? limit,
  ) async {
    try {
      final response = await dio.get(
        "${ConstantsVariables.urlBase}${ConstantsVariables.urlPromo}",
        queryParameters: {
          "merchant_id": merchantId,
          "search": search,
          "page": page,
          "limit": limit,
        },
      );
      return PromoModel.fromJson(
        response.data,
      );
    } on DioException catch (e) {
      throw exception(e);
    }
  }

  @override
  Future<String> postCurrentPromo(
    int? merchantId,
    int? productId,
    int? price,
    int? discount,
    String? endDate,
  ) async {
    try {
      final response = await dio.post(
        "${ConstantsVariables.urlBase}${ConstantsVariables.urlPromo}/create",
        data: {
          "merchant_id": merchantId,
          "price": price,
          "discount": discount,
          "product_id": productId,
          "end_date": endDate,
        },
      );
      return response.data["message"] ?? "Sukses";
    } on DioException catch (e) {
      throw exception(e);
    }
  }
}
