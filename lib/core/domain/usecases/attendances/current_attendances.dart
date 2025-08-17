import 'package:tokona/packages/packages.dart';

class GetCurrentAttendances {
  final AttendancesRepository attendancesRepository;

  GetCurrentAttendances(
    this.attendancesRepository,
  );

  Future<Either<Failure, Attendances>> get() {
    return attendancesRepository.getCurrentAttendances();
  }

  Future<Either<Failure, String>> post(
    double? longitude,
    double? latitude,
    int? status,
    String? reason,
  ) {
    return attendancesRepository.postCurrentAttendances(
      longitude,
      latitude,
      status,
      reason,
    );
  }
}
