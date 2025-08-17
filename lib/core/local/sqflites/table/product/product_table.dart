import 'package:tokona/packages/packages.dart';

const String productTable = "product";

class ProductTable {
  final sqflites = locator<Sqflites>();

  Future<void> createProductTable(Database db) async {
    const id = "INT";
    const code = "TEXT";
    const photo = "TEXT";
    const name = "TEXT";
    const description = "TEXT";
    const price = "INT";
    const available = "INT";
    const productId = "INT";
    const merchantId = "INT";
    const createdAt = "TEXT";
    const updatedAt = "TEXT";
    await db.execute(
      "CREATE TABLE $productTable (id $id, code $code, photo $photo, name $name, description $description, price $price, available $available, productId $productId, merchantId $merchantId, createdAt $createdAt, updatedAt $updatedAt)",
    );
  }

  Future<void> dropProductTable(Database db) async {
    await db.execute("DROP TABLE IF EXISTS $productTable");
  }

  Future<int> createProduct(
    ProductDataModel productDataModel,
  ) async {
    final db = await sqflites.database;
    return await db.insert(
      productTable,
      productDataModel.toJson(),
    );
  }

  Future<ProductModel> getProduct(
    int? merchantId,
  ) async {
    final db = await sqflites.database;
    final result = await db.query(
      productTable,
      where: "merchantId = ?",
      whereArgs: [merchantId],
    );
    return ProductModel(
      message: "Success",
      data: result
          .map(
            (e) => ProductDataModel.fromJson(e),
          )
          .toList(),
    );
  }

  Future<int> truncateProduct() async {
    final db = await sqflites.database;
    return await db.delete(
      productTable,
    );
  }
}
