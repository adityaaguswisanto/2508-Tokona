import 'package:tokona/packages/packages.dart';

class ConstantsVariables {
  static String urlBase = Envs().e("BASE_URL");
  static String urlLogin = Envs().e("LOGIN_URL");
  static String urlMerchant = Envs().e("MERCHANT_URL");
  static String urlAttendances = Envs().e("ATTENDANCES_URL");
  static String urlProduct = Envs().e("PRODUCT_URL");
  static String urlPromo = Envs().e("PROMO_URL");

  static const responseNotFound = "Terjadi kesalahan pada API";
  static const responseErrorServer = "Error Server";
  static const responseNoInternet =
      "Sedang Offline atau Terjadi kesalahan lain";
  static const responseServerBusy =
      "Maaf, server sedang sibuk, mohon tunggu beberapa saat lagi dan segarkan kembali";
  static const responseOffline =
      "Pastikan perangkatmu terhubung ke internet, lalu segarkan kembali";
}
