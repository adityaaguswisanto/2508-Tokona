import 'package:tokona/packages/packages.dart';

class AttendancesData extends Equatable {
  final int? id;
  final double? longitude;
  final double? latitude;
  final int? status;
  final String? reason;
  final String? createdAt;
  final String? updatedAt;

  const AttendancesData({
    required this.id,
    required this.longitude,
    required this.latitude,
    required this.status,
    required this.reason,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    longitude,
    latitude,
    status,
    reason,
    createdAt,
    updatedAt,
  ];
}

final List<String> listAttendancesReason = [
  "Sakit / Tidak Fit",
  "Izin Pribadi",
  "Cuti Tahunan",
  "Kegiatan Keluarga",
  "Transportasi / Kendala Perjalanan",
  "Work From Home",
  "Dinas Luar Kota",
  "Lainnya",
];
