import 'package:tokona/packages/packages.dart';

enum LoginResponse {
  loading,
  success,
  failure,
}

final class LoginState extends Equatable {
  final LoginResponse status;
  final Login? login;
  final String message;
  final int statusCode;

  const LoginState({
    this.status = LoginResponse.loading,
    this.login,
    this.message = "",
    this.statusCode = 0,
  });

  LoginState copyWith({
    LoginResponse? status,
    Login? login,
    String? message,
    int? statusCode,
  }) {
    return LoginState(
      status: status ?? this.status,
      login: login ?? this.login,
      message: message ?? this.message,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  @override
  List<Object?> get props => [
    status,
    login,
    message,
    statusCode,
  ];
}
