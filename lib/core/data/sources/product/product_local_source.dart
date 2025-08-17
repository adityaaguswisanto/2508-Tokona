import 'package:tokona/packages/packages.dart';

abstract class ProductLocalSource {
  Future<ProductModel> getCurrentProduct(
    int? merchantId,
  );

  Future<void> postCurrentProduct(
    ProductModel productModel,
  );
}

class ProductLocalSourceImpl implements ProductLocalSource {
  @override
  Future<ProductModel> getCurrentProduct(
    int? merchantId,
  ) async {
    return await ProductTable().getProduct(
      merchantId,
    );
  }

  @override
  Future<void> postCurrentProduct(
    ProductModel productModel,
  ) async {
    await ProductTable().truncateProduct();
    if (productModel.data!.isNotEmpty) {
      for (var item in productModel.data!) {
        await ProductTable().createProduct(
          ProductDataModel(
            id: item.id,
            code: item.code,
            photo: item.photo,
            name: item.name,
            description: item.description,
            price: item.price,
            available: item.available,
            productId: item.productId,
            merchantId: item.merchantId,
            createdAt: item.createdAt,
            updatedAt: item.updatedAt,
          ),
        );
      }
    }
  }
}
