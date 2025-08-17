import 'package:tokona/packages/packages.dart';

class Toasts {
  static regular(String msg) {
    Fluttertoast.showToast(
      msg: msg,
    );
  }
}
