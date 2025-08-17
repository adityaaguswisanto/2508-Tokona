import 'package:tokona/packages/packages.dart';

abstract class LoginRepository {
  Future<Either<Failure, Login>> postCurrentLogin(
    String? username,
    String? password,
  );
}
