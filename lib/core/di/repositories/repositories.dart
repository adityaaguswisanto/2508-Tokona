import 'package:tokona/packages/packages.dart';

Future<void> repositories() async {
  locator.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(
      loginSource: locator(),
    ),
  );
  locator.registerLazySingleton<MerchantRepository>(
    () => MerchantRepositoryImpl(
      merchantRemoteSource: locator(),
      merchantLocalSource: locator(),
    ),
  );
  locator.registerLazySingleton<AttendancesRepository>(
    () => AttendancesRepositoryImpl(
      attendancesRemoteSource: locator(),
      attendancesLocalSource: locator(),
    ),
  );
  locator.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      productRemoteSource: locator(),
      productLocalSource: locator(),
    ),
  );
  locator.registerLazySingleton<PromoRepository>(
    () => PromoRepositoryImpl(
      promoRemoteSource: locator(),
      promoLocalSource: locator(),
    ),
  );
}
