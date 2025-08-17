import 'package:tokona/packages/packages.dart';

abstract class MerchantLocalSource {
  Future<MerchantModel> getCurrentMerchant();

  Future<void> postCurrentMerchant(
    MerchantModel merchantModel,
  );
}

class MerchantLocalSourceImpl implements MerchantLocalSource {
  @override
  Future<MerchantModel> getCurrentMerchant() async {
    return await MerchantTable().getMerchant();
  }

  @override
  Future<void> postCurrentMerchant(
    MerchantModel merchantModel,
  ) async {
    await MerchantTable().truncateMerchant();
    if (merchantModel.data!.isNotEmpty) {
      for (var item in merchantModel.data!) {
        await MerchantTable().createMerchant(
          MerchantDataModel(
            id: item.id,
            code: item.code,
            name: item.name,
            address: item.address,
            createdAt: item.createdAt,
            updatedAt: item.updatedAt,
          ),
        );
      }
    }
  }
}
