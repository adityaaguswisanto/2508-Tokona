import 'package:tokona/packages/packages.dart';

sealed class AttendancesEvent extends Equatable {
  const AttendancesEvent();

  @override
  List<Object?> get props => [];
}

class AttendancesSubmitted extends AttendancesEvent {
  final double? longitude;
  final double? latitude;
  final int? status;
  final String? reason;

  const AttendancesSubmitted({
    required this.longitude,
    required this.latitude,
    required this.status,
    required this.reason,
  });

  @override
  List<Object?> get props => [
    longitude,
    latitude,
    status,
    reason,
  ];
}

class AttendancesGetted extends AttendancesEvent {
  const AttendancesGetted();
}

class AttendancesUpdateWorkingHours extends AttendancesEvent {
  final String workingHours;

  const AttendancesUpdateWorkingHours(this.workingHours);
}
