import 'package:tokona/packages/packages.dart';

class ServerException implements Exception {
  final String? error;
  final int? statusCode;

  const ServerException(
    this.error,
    this.statusCode,
  );
}

Future<ServerException> exception(DioException e) {
  if (e.response?.statusCode != null) {
    if (e.response!.statusCode! >= 500) {
      throw ServerException(
        ConstantsVariables.responseErrorServer,
        e.response?.statusCode,
      );
    } else if (e.response!.statusCode == 404) {
      throw ServerException(
        ConstantsVariables.responseNotFound,
        e.response?.statusCode,
      );
    } else {
      throw ServerException(
        e.response?.data["error"] ?? e.response?.data["message"],
        e.response?.statusCode,
      );
    }
  } else {
    throw ServerException(
      ConstantsVariables.responseNoInternet,
      e.response?.statusCode,
    );
  }
}
