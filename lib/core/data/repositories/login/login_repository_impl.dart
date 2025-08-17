import 'package:tokona/packages/packages.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginSource loginSource;

  const LoginRepositoryImpl({
    required this.loginSource,
  });

  @override
  Future<Either<Failure, Login>> postCurrentLogin(
    String? username,
    String? password,
  ) async {
    try {
      final result = await loginSource.postCurrentLogin(
        username,
        password,
      );
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          e.error.toString(),
          e.statusCode,
        ),
      );
    } on SocketException {
      return const Left(
        ConnectionFailure(
          ConstantsVariables.responseNoInternet,
          500,
        ),
      );
    }
  }
}
