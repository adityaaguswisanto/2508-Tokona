import 'package:tokona/packages/packages.dart';

class AttendancesBloc extends Bloc<AttendancesEvent, AttendancesState> {
  final GetCurrentAttendances getCurrentAttendances;
  StreamSubscription<int>? attendanceSubscription;

  AttendancesBloc(this.getCurrentAttendances)
    : super(const AttendancesState()) {
    on<AttendancesGetted>((event, emit) async {
      emit(
        state.copyWith(
          status: AttendancesResponse.loading,
        ),
      );
      final result = await getCurrentAttendances.get();
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              status: failure.statusCode == 500
                  ? AttendancesResponse.offline
                  : AttendancesResponse.failure,
              message: failure.message,
              statusCode: failure.statusCode,
            ),
          );
        },
        (attendances) {
          emit(
            state.copyWith(
              status: AttendancesResponse.success,
              attendances: attendances,
            ),
          );

          final createdAt = attendances.data?.createdAt;
          final status = attendances.data?.status;

          if (status == 1) {
            if (createdAt != null) {
              attendanceSubscription?.cancel();
              final inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
              final startDateUTC = inputFormat.parseUtc(createdAt);
              final startDateWIB = startDateUTC.add(const Duration(hours: 7));
              attendanceSubscription =
                  Stream<int>.periodic(
                    const Duration(seconds: 1),
                    (x) => x,
                  ).listen((_) {
                    final now = DateTime.now();
                    final diff = now.isAfter(startDateWIB)
                        ? now.difference(startDateWIB)
                        : Duration.zero;

                    final hours = diff.inHours;
                    final minutes = diff.inMinutes % 60;
                    final seconds = diff.inSeconds % 60;

                    final workingHours =
                        "${hours.toString().padLeft(2, '0')}:"
                        "${minutes.toString().padLeft(2, '0')}:"
                        "${seconds.toString().padLeft(2, '0')}";

                    add(AttendancesUpdateWorkingHours(workingHours));
                  });
            }
          } else {
            attendanceSubscription?.cancel();
          }
        },
      );
    });
    on<AttendancesUpdateWorkingHours>((event, emit) {
      emit(state.copyWith(workingHours: event.workingHours));
    });
    on<AttendancesSubmitted>((event, emit) async {
      emit(
        state.copyWith(
          status: AttendancesResponse.loading,
        ),
      );
      final result = await getCurrentAttendances.post(
        event.longitude,
        event.latitude,
        event.status,
        event.reason,
      );
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              status: AttendancesResponse.failure,
              message: failure.message,
              statusCode: failure.statusCode,
            ),
          );
        },
        (message) {
          emit(
            state.copyWith(
              status: AttendancesResponse.success,
            ),
          );
        },
      );
    });
  }
}
