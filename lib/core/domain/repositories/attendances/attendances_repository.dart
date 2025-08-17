import 'package:tokona/packages/packages.dart';

abstract class AttendancesRepository {
  Future<Either<Failure, Attendances>> getCurrentAttendances();

  Future<Either<Failure, String>> postCurrentAttendances(
    double? longitude,
    double? latitude,
    int? status,
    String? reason,
  );
}
