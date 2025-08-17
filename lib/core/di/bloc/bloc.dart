import 'package:tokona/packages/packages.dart';

Future<void> bloc() async {
  locator.registerFactory(
    () => LoginBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MerchantBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => AttendancesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => ProductBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PromoBloc(
      locator(),
    ),
  );
}
