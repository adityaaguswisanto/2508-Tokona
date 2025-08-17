import 'package:tokona/packages/packages.dart';

export 'attendances_data.dart';

class Attendances extends Equatable {
  final String? message;
  final AttendancesData? data;

  const Attendances({
    required this.message,
    required this.data,
  });

  @override
  List<Object?> get props => [
    message,
    data,
  ];
}
