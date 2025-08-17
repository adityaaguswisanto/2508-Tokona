import 'package:tokona/packages/packages.dart';

abstract class AttendancesRemoteSource {
  Future<AttendancesModel> getCurrentAttendances();

  Future<String> postCurrentAttendances(
    double? longitude,
    double? latitude,
    int? status,
    String? reason,
  );
}

class AttendancesRemoteSourceImpl implements AttendancesRemoteSource {
  final Dio dio;

  AttendancesRemoteSourceImpl({
    required this.dio,
  });

  @override
  Future<AttendancesModel> getCurrentAttendances() async {
    try {
      final response = await dio.get(
        "${ConstantsVariables.urlBase}${ConstantsVariables.urlAttendances}",
      );

      return AttendancesModel.fromJson(response.data);
    } on DioException catch (e) {
      throw exception(e);
    }
  }

  @override
  Future<String> postCurrentAttendances(
    double? longitude,
    double? latitude,
    int? status,
    String? reason,
  ) async {
    try {
      final response = await dio.post(
        "${ConstantsVariables.urlBase}${ConstantsVariables.urlAttendances}/create",
        data: {
          "longitude": longitude,
          "latitude": latitude,
          "status": status,
          "reason": reason,
        },
      );
      return response.data["message"] ?? "Sukses!";
    } on DioException catch (e) {
      throw exception(e);
    }
  }
}
