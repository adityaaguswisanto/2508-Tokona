import 'package:tokona/packages/packages.dart';
export 'table/table.dart';

class Sqflites {
  static final Sqflites instance = Sqflites._init();

  static Database? _database;

  Sqflites._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('tokona.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    final version = int.parse(
      await Applications().buildNumber(),
    );

    return await openDatabase(
      path,
      version: version,
      onCreate: createDatabase,
      onUpgrade: upgradeDatabase,
    );
  }

  Future<void> upgradeDatabase(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    await AttendancesTable().dropAttendancesTable(db);
    await MerchantTable().dropMerchantTable(db);
    await ProductTable().dropProductTable(db);
    await PromoTable().dropPromoTable(db);

    await createDatabase(db, newVersion);
  }

  Future<void> createDatabase(Database db, int version) async {
    AttendancesTable().createAttendancesTable(
      db,
    );
    MerchantTable().createMerchantTable(
      db,
    );
    ProductTable().createProductTable(
      db,
    );
    PromoTable().createPromoTable(
      db,
    );
  }
}
