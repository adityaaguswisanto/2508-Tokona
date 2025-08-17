import 'package:tokona/packages/packages.dart';

class AttendancesModel extends Equatable {
  final String? message;
  final AttendancesDataModel? data;

  const AttendancesModel({
    required this.message,
    required this.data,
  });

  factory AttendancesModel.fromJson(Map<String, dynamic> json) {
    return AttendancesModel(
      message: json["message"],
      data: json["data"] != null
          ? AttendancesDataModel.fromJson(json["data"])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data?.toJson(),
  };

  Attendances toEntity() => Attendances(
    message: message,
    data: AttendancesData(
      id: data?.id,
      longitude: data?.longitude,
      latitude: data?.latitude,
      status: data?.status,
      reason: data?.reason,
      createdAt: data?.createdAt,
      updatedAt: data?.updatedAt,
    ),
  );

  @override
  List<Object?> get props => [
    message,
    data,
  ];
}
