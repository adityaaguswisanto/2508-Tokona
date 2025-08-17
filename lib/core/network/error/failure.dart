import 'package:tokona/packages/packages.dart';

abstract class Failure extends Equatable {
  final String? message;
  final int? statusCode;

  const Failure({
    required this.message,
    required this.statusCode,
  });

  @override
  List<Object?> get props => [
    message,
    statusCode,
  ];
}

class ServerFailure extends Failure {
  const ServerFailure(
    String? message,
    int? statusCode,
  ) : super(
        message: message,
        statusCode: statusCode,
      );
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(
    String? message,
    int? statusCode,
  ) : super(
        message: message,
        statusCode: statusCode,
      );
}
