import 'package:tokona/packages/packages.dart';

class Secures {
  final FlutterSecureStorage flutterSecureStorage =
      const FlutterSecureStorage();

  static const nik = "Nik";
  static const name = "Name";
  static const position = "Position";
  static const createdAt = "CreatedAt";
  static const token = "Token";

  Future<void> saveNik(String value) async {
    await flutterSecureStorage.write(
      key: nik,
      value: value,
    );
  }

  Future<void> saveName(String value) async {
    await flutterSecureStorage.write(
      key: name,
      value: value,
    );
  }

  Future<void> savePosition(String value) async {
    await flutterSecureStorage.write(
      key: position,
      value: value,
    );
  }

  Future<void> saveCreatedAt(String value) async {
    await flutterSecureStorage.write(
      key: createdAt,
      value: value,
    );
  }

  Future<void> saveToken(String value) async {
    await flutterSecureStorage.write(
      key: token,
      value: value,
    );
  }

  /// --------------------------------------- This is get function ---------------------------------------

  Future<String> getNik() async {
    return await flutterSecureStorage.read(
          key: nik,
        ) ??
        "";
  }

  Future<String> getName() async {
    return await flutterSecureStorage.read(
          key: name,
        ) ??
        "";
  }

  Future<String> getPosition() async {
    return await flutterSecureStorage.read(
          key: position,
        ) ??
        "";
  }

  Future<String> getCreatedAt() async {
    return await flutterSecureStorage.read(
          key: createdAt,
        ) ??
        "";
  }

  Future<String> getToken() async {
    return await flutterSecureStorage.read(
          key: token,
        ) ??
        "";
  }

  Future<void> clearSession() async {
    await flutterSecureStorage.deleteAll();
  }
}
