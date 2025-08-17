import 'package:tokona/packages/packages.dart';

class CustomInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    debugPrint("REQUEST[${options.method}] => PATH: ${options.path}");
    options.headers["Authorization"] = "Bearer ${await Secures().getToken()}";
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    debugPrint(
      "ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}",
    );
    debugPrint(
      "MESSAGE[${err.response?.data}] => PATH: ${err.requestOptions.path}",
    );
    return super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
      "RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}",
    );
    return super.onResponse(response, handler);
  }
}
