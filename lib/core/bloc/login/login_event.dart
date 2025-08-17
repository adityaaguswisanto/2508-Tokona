import 'package:tokona/packages/packages.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginSubmitted extends LoginEvent {
  final String? username;
  final String? password;

  const LoginSubmitted({
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [
    username,
    password,
  ];
}
