import 'package:tokona/packages/packages.dart';

abstract class AttendancesLocalSource {
  Future<AttendancesModel> getCurrentAttendances();

  Future<void> postCurrentAttendances(
    AttendancesModel attendancesModel,
  );
}

class AttendancesLocalSourceImpl implements AttendancesLocalSource {
  @override
  Future<AttendancesModel> getCurrentAttendances() async {
    return await AttendancesTable().getAttendances();
  }

  @override
  Future<void> postCurrentAttendances(
    AttendancesModel attendancesModel,
  ) async {
    await AttendancesTable().truncateAttendances();
    if (attendancesModel.data != null) {
      await AttendancesTable().createAttendances(
        AttendancesDataModel(
          id: attendancesModel.data?.id,
          longitude: attendancesModel.data?.longitude,
          latitude: attendancesModel.data?.latitude,
          status: attendancesModel.data?.status,
          reason: attendancesModel.data?.reason,
          createdAt: attendancesModel.data?.createdAt,
          updatedAt: attendancesModel.data?.updatedAt,
        ),
      );
    }
  }
}
