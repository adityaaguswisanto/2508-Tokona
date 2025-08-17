import 'package:tokona/packages/packages.dart';

const String promoTable = "promo";

class PromoTable {
  final sqflites = locator<Sqflites>();

  Future<void> createPromoTable(Database db) async {
    const id = "INT";
    const code = "TEXT";
    const photo = "TEXT";
    const name = "TEXT";
    const description = "TEXT";
    const price = "INT";
    const discount = "INT";
    const endDate = "TEXT";
    const merchantId = "INT";
    const createdAt = "TEXT";
    const updatedAt = "TEXT";
    await db.execute(
      "CREATE TABLE $promoTable (id $id, code $code, photo $photo, name $name, description $description, price $price, discount $discount, endDate $endDate, merchantId $merchantId, createdAt $createdAt, updatedAt $updatedAt)",
    );
  }

  Future<void> dropPromoTable(Database db) async {
    await db.execute("DROP TABLE IF EXISTS $promoTable");
  }

  Future<int> createPromo(
    PromoDataModel promoDataModel,
  ) async {
    final db = await sqflites.database;
    return await db.insert(
      promoTable,
      promoDataModel.toJson(),
    );
  }

  Future<PromoModel> getPromo(
    int? merchantId,
  ) async {
    final db = await sqflites.database;
    final result = await db.query(
      promoTable,
      where: "merchantId = ?",
      whereArgs: [merchantId],
    );
    return PromoModel(
      message: "Success",
      data: result
          .map(
            (e) => PromoDataModel.fromJson(e),
          )
          .toList(),
    );
  }

  Future<int> truncatePromo() async {
    final db = await sqflites.database;
    return await db.delete(
      promoTable,
    );
  }
}
