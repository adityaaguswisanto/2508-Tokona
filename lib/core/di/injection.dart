import 'package:tokona/packages/packages.dart';

final locator = GetIt.instance;

void init() {
  //bloc
  bloc();

  // usecase
  usecases();

  // repository
  repositories();

  // data source
  sources();

  // internal
  internal();
}
