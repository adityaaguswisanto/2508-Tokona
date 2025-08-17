import 'package:tokona/packages/packages.dart';

class AttendancesDataModel extends Equatable {
  final int? id;
  final double? longitude;
  final double? latitude;
  final int? status;
  final String? reason;
  final String? createdAt;
  final String? updatedAt;

  const AttendancesDataModel({
    required this.id,
    required this.longitude,
    required this.latitude,
    required this.status,
    required this.reason,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AttendancesDataModel.fromJson(Map<String, dynamic> json) {
    return AttendancesDataModel(
      id: json["id"],
      longitude: json["longitude"],
      latitude: json["latitude"],
      status: json["status"],
      reason: json["reason"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "longitude": longitude,
    "latitude": latitude,
    "status": status,
    "reason": reason,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };

  AttendancesData toEntity() => AttendancesData(
    id: id,
    longitude: longitude,
    latitude: latitude,
    status: status,
    reason: reason,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

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
