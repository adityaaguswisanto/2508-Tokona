import 'package:tokona/packages/packages.dart';

class LoginModel extends Equatable {
  final String? message;
  final LoginDataModel? data;

  const LoginModel({
    required this.message,
    required this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      message: json["message"],
      data: LoginDataModel.fromJson(
        json["data"],
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data?.toJson(),
  };

  Login toEntity() => Login(
    message: message,
    loginData: data?.toEntity(),
  );

  @override
  List<Object?> get props => [
    message,
    data,
  ];
}
