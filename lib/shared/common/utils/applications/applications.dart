import 'package:tokona/packages/packages.dart';

class Applications {
  Future<String> version() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    return version;
  }

  Future<String> appName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    return appName;
  }

  Future<String> packageName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String packageName = packageInfo.packageName;
    return packageName;
  }

  Future<String> buildNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String buildNumber = packageInfo.buildNumber;
    return buildNumber;
  }
}
