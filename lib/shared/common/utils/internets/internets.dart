import 'package:tokona/packages/packages.dart';

class Internets {
  Future<bool> c() async {
    bool result = await InternetConnection().hasInternetAccess;
    return result;
  }
}
