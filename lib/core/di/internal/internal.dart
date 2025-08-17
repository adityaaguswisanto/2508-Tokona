import 'package:tokona/packages/packages.dart';

Future<void> internal() async {
  locator.registerLazySingleton(
    () => CustomDio().dio,
  );

  locator.registerLazySingleton(
    () => Sqflites.instance,
  );
}
