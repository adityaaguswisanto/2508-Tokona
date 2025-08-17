import 'package:tokona/packages/packages.dart';

abstract class PromoLocalSource {
  Future<PromoModel> getCurrentPromo(
    int? merchantId,
  );

  Future<void> postCurrentPromo(
    PromoModel promoModel,
  );
}

class PromoLocalSourceImpl implements PromoLocalSource {
  @override
  Future<PromoModel> getCurrentPromo(
    int? merchantId,
  ) async {
    return await PromoTable().getPromo(
      merchantId,
    );
  }

  @override
  Future<void> postCurrentPromo(
    PromoModel promoModel,
  ) async {
    await PromoTable().truncatePromo();
    if (promoModel.data!.isNotEmpty) {
      for (var item in promoModel.data!) {
        await PromoTable().createPromo(
          PromoDataModel(
            id: item.id,
            code: item.code,
            photo: item.photo,
            name: item.name,
            description: item.description,
            price: item.price,
            discount: item.discount,
            endDate: item.endDate,
            merchantId: item.merchantId,
            createdAt: item.createdAt,
            updatedAt: item.updatedAt,
          ),
        );
      }
    }
  }
}
