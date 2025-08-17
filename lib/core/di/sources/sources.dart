import 'package:tokona/packages/packages.dart';

Future<void> sources() async {
  locator.registerLazySingleton<LoginSource>(
    () => LoginSourceImpl(
      dio: locator(),
    ),
  );
  locator.registerLazySingleton<MerchantRemoteSource>(
    () => MerchantRemoteSourceImpl(
      dio: locator(),
    ),
  );
  locator.registerLazySingleton<MerchantLocalSource>(
    () => MerchantLocalSourceImpl(),
  );
  locator.registerLazySingleton<AttendancesRemoteSource>(
    () => AttendancesRemoteSourceImpl(
      dio: locator(),
    ),
  );
  locator.registerLazySingleton<AttendancesLocalSource>(
    () => AttendancesLocalSourceImpl(),
  );
  locator.registerLazySingleton<ProductRemoteSource>(
    () => ProductRemoteSourceImpl(
      dio: locator(),
    ),
  );
  locator.registerLazySingleton<ProductLocalSource>(
    () => ProductLocalSourceImpl(),
  );
  locator.registerLazySingleton<PromoRemoteSource>(
    () => PromoRemoteSourceImpl(
      dio: locator(),
    ),
  );
  locator.registerLazySingleton<PromoLocalSource>(
    () => PromoLocalSourceImpl(),
  );
}
