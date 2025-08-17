import 'package:tokona/packages/packages.dart';

abstract class LoginSource {
  Future<LoginModel> postCurrentLogin(
    String? username,
    String? password,
  );
}

class LoginSourceImpl implements LoginSource {
  final Dio dio;

  LoginSourceImpl({
    required this.dio,
  });

  @override
  Future<LoginModel> postCurrentLogin(
    String? username,
    String? password,
  ) async {
    try {
      final response = await dio.post(
        "${ConstantsVariables.urlBase}${ConstantsVariables.urlLogin}/login",
        data: {
          "username": username,
          "password": password,
        },
      );

      await Secures().saveNik(
        response.data["data"]["nik"].toString(),
      );

      await Secures().saveName(
        response.data["data"]["name"],
      );

      await Secures().savePosition(
        response.data["data"]["position"],
      );

      await Secures().saveCreatedAt(
        response.data["data"]["createdAt"],
      );

      await Secures().saveToken(
        response.data["data"]["token"],
      );
      return LoginModel.fromJson(response.data);
    } on DioException catch (e) {
      throw exception(e);
    }
  }
}
