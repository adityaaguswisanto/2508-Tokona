import 'package:tokona/packages/packages.dart';

abstract class ProductRemoteSource {
  Future<ProductModel> getCurrentProduct(
    int? merchantId,
    String? search,
    int? page,
    int? limit,
  );

  Future<String> putCurrentProduct(
    int? id,
    int? available,
  );
}

class ProductRemoteSourceImpl implements ProductRemoteSource {
  final Dio dio;

  ProductRemoteSourceImpl({
    required this.dio,
  });

  @override
  Future<ProductModel> getCurrentProduct(
    int? merchantId,
    String? search,
    int? page,
    int? limit,
  ) async {
    try {
      final response = await dio.get(
        "${ConstantsVariables.urlBase}${ConstantsVariables.urlProduct}",
        queryParameters: {
          "merchant_id": merchantId,
          "search": search,
          "page": page,
          "limit": limit,
        },
      );
      return ProductModel.fromJson(
        response.data,
      );
    } on DioException catch (e) {
      throw exception(e);
    }
  }

  @override
  Future<String> putCurrentProduct(
    int? id,
    int? available,
  ) async {
    try {
      final response = await dio.put(
        "${ConstantsVariables.urlBase}${ConstantsVariables.urlProduct}/available/$id",
        data: {
          "available": available,
        },
      );
      return response.data["message"] ?? "Sukses!";
    } on DioException catch (e) {
      throw exception(e);
    }
  }
}
