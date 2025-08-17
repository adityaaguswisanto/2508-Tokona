import 'package:tokona/packages/packages.dart';

class CustomDio {
  CustomDio();

  Dio get dio => _getDio();

  Dio _getDio() {
    BaseOptions options = BaseOptions(
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      baseUrl: Envs().e(
        "BASE_URL",
      ),
    );
    Dio dio = Dio(options);
    dio.interceptors.addAll(<Interceptor>[CustomInterceptor()]);
    return dio;
  }
}
