import 'package:tokona/packages/packages.dart';

export 'login_data.dart';

class Login extends Equatable {
  final String? message;
  final LoginData? loginData;

  const Login({
    required this.message,
    required this.loginData,
  });

  @override
  List<Object?> get props => [
    message,
    loginData,
  ];
}
