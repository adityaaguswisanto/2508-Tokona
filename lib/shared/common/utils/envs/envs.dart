import 'package:tokona/packages/packages.dart';

class Envs {
  String e(url) {
    return dotenv.env[url.toString().toUpperCase()].toString();
  }

  Future<void> l({
    String? url = ".env",
  }) {
    return dotenv.load(
      fileName: url.toString(),
    );
  }
}
