import 'package:tokona/packages/packages.dart';

const String merchantTable = "merchant";

class MerchantTable {
  final sqflites = locator<Sqflites>();

  Future<void> createMerchantTable(Database db) async {
    const id = "INT";
    const code = "TEXT";
    const name = "TEXT";
    const address = "TEXT";
    const createdAt = "TEXT";
    const updatedAt = "TEXT";
    await db.execute(
      "CREATE TABLE $merchantTable (id $id, code $code, name $name, address $address, createdAt $createdAt, updatedAt $updatedAt)",
    );
  }

  Future<void> dropMerchantTable(Database db) async {
    await db.execute("DROP TABLE IF EXISTS $merchantTable");
  }

  Future<int> createMerchant(
    MerchantDataModel merchantDataModel,
  ) async {
    final db = await sqflites.database;
    return await db.insert(
      merchantTable,
      merchantDataModel.toJson(),
    );
  }

  Future<MerchantModel> getMerchant() async {
    final db = await sqflites.database;
    final result = await db.query(
      merchantTable,
    );
    return MerchantModel(
      message: "Success",
      data: result
          .map(
            (e) => MerchantDataModel.fromJson(e),
          )
          .toList(),
    );
  }

  Future<int> truncateMerchant() async {
    final db = await sqflites.database;
    return await db.delete(merchantTable);
  }
}
