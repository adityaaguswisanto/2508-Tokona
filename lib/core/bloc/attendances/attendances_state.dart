import 'package:tokona/packages/packages.dart';

enum AttendancesResponse {
  loading,
  success,
  failure,
  offline,
}

final class AttendancesState extends Equatable {
  final AttendancesResponse status;
  final Attendances? attendances;
  final String workingHours;
  final String message;
  final int statusCode;

  const AttendancesState({
    this.status = AttendancesResponse.loading,
    this.attendances,
    this.workingHours = "00:00:00",
    this.message = "",
    this.statusCode = 0,
  });

  AttendancesState copyWith({
    AttendancesResponse? status,
    Attendances? attendances,
    String? workingHours,
    String? message,
    int? statusCode,
  }) {
    return AttendancesState(
      status: status ?? this.status,
      attendances: attendances ?? this.attendances,
      workingHours: workingHours ?? this.workingHours,
      message: message ?? this.message,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  @override
  List<Object?> get props => [
    status,
    attendances,
    workingHours,
    message,
    statusCode,
  ];
}
