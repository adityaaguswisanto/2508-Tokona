import 'package:tokona/packages/packages.dart';

const String attendancesTable = "attendances";

class AttendancesTable {
  final sqflites = locator<Sqflites>();

  Future<void> createAttendancesTable(Database db) async {
    const id = "INT";
    const longitude = "REAL";
    const latitude = "REAL";
    const status = "INT";
    const reason = "TEXT";
    const createdAt = "TEXT";
    const updatedAt = "TEXT";
    await db.execute(
      "CREATE TABLE $attendancesTable (id $id, longitude $longitude, latitude $latitude, status $status, reason $reason, createdAt $createdAt, updatedAt $updatedAt)",
    );
  }

  Future<void> dropAttendancesTable(Database db) async {
    await db.execute("DROP TABLE IF EXISTS $attendancesTable");
  }

  Future<int> createAttendances(
    AttendancesDataModel attendancesDataModel,
  ) async {
    final db = await sqflites.database;
    return await db.insert(
      attendancesTable,
      attendancesDataModel.toJson(),
    );
  }

  Future<AttendancesModel> getAttendances() async {
    final db = await sqflites.database;
    final result = await db.query(
      attendancesTable,
    );
    if (result.isEmpty) {
      return const AttendancesModel(
        message: "Success",
        data: null,
      );
    }
    return AttendancesModel(
      message: "Success",
      data: AttendancesDataModel.fromJson(
        result.first,
      ),
    );
  }

  Future<int> truncateAttendances() async {
    final db = await sqflites.database;
    return await db.delete(attendancesTable);
  }
}
