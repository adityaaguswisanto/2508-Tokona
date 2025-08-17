import 'package:tokona/packages/packages.dart';

Future<void> usecases() async {
  locator.registerLazySingleton(
    () => GetCurrentLogin(
      locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetCurrentMerchant(
      locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetCurrentAttendances(
      locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetCurrentProduct(
      locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetCurrentPromo(
      locator(),
    ),
  );
}
