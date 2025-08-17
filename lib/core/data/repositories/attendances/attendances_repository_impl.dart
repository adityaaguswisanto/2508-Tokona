import 'package:tokona/packages/packages.dart';

class AttendancesRepositoryImpl implements AttendancesRepository {
  final AttendancesRemoteSource attendancesRemoteSource;
  final AttendancesLocalSource attendancesLocalSource;

  const AttendancesRepositoryImpl({
    required this.attendancesRemoteSource,
    required this.attendancesLocalSource,
  });

  @override
  Future<Either<Failure, Attendances>> getCurrentAttendances() async {
    try {
      final hasInternet = await Internets().c();
      final result = hasInternet
          ? await attendancesRemoteSource.getCurrentAttendances()
          : await attendancesLocalSource.getCurrentAttendances();
      if (hasInternet) {
        await attendancesLocalSource.postCurrentAttendances(result);
      }
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

  @override
  Future<Either<Failure, String>> postCurrentAttendances(
    double? longitude,
    double? latitude,
    int? status,
    String? reason,
  ) async {
    try {
      final result = await attendancesRemoteSource.postCurrentAttendances(
        longitude,
        latitude,
        status,
        reason,
      );
      return Right(result);
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
