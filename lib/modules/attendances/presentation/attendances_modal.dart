import 'package:tokona/packages/packages.dart';

class AttendancesModal extends StatefulWidget {
  final AttendancesBloc attendancesBloc;
  final Attendances? attendances;

  const AttendancesModal({
    super.key,
    required this.attendancesBloc,
    required this.attendances,
  });

  @override
  State<AttendancesModal> createState() => _AttendancesModalState();
}

class _AttendancesModalState extends State<AttendancesModal> {
  final attendancesBloc = locator<AttendancesBloc>();

  int status = 0;
  String? reason;
  bool loading = false;

  @override
  void dispose() {
    attendancesBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.attendances?.data;
    return BlocListener<AttendancesBloc, AttendancesState>(
      bloc: attendancesBloc,
      listener: (context, state) {
        switch (state.status) {
          case AttendancesResponse.loading:
            setState(() {
              loading = true;
            });
            break;
          case AttendancesResponse.success:
            setState(() {
              loading = false;
            });
            widget.attendancesBloc.add(
              const AttendancesGetted(),
            );
            Navigations.back(context);
            break;
          case AttendancesResponse.offline:
            break;
          case AttendancesResponse.failure:
            setState(() {
              loading = false;
            });
            Toasts.regular(state.message);
            break;
        }
      },
      child: Modals(
        loading: loading,
        title: "Absensi",
        children: [
          Text(
            "Silakan pilih sesuai dengan kondisi Anda",
            style: Texts.regular(),
          ),
          Row(
            children: [
              AttendancesRadio(
                value: data?.status == 1 ? 3 : 1,
                title: data?.status == 1 ? "Pulang Kerja" : "Masuk Kerja",
                status: status,
                onChanged: (int? value) => setState(() {
                  status = value!;
                  reason = null;
                }),
              ),
              if (data?.status == null || data?.status == 2)
                AttendancesRadio(
                  value: 2,
                  title: "Absen",
                  status: status,
                  onChanged: (int? value) => setState(() {
                    status = value!;
                  }),
                ),
            ],
          ),
          if (status == 2)
            AttendancesDropdown(
              items: listAttendancesReason,
              value: reason,
              onChanged: (value) => setState(() {
                reason = value;
              }),
            ),
          SizedBox(
            height: 16.h,
          ),
          loading
              ? const Center(
                  child: Loadings(),
                )
              : SizedBox(
                  width: Sizes.width(context),
                  child: Buttons(
                    onPressed: () {
                      if (status == 0) {
                        Toasts.regular("Harus dipilih");
                        return;
                      }

                      if (status == 2 && reason == null) {
                        Toasts.regular("Alasan harus diisi");
                        return;
                      }

                      attendancesBloc.add(
                        AttendancesSubmitted(
                          longitude: 1238.412234,
                          latitude: 95834.34539,
                          status: status == 3 ? 2 : status,
                          reason: reason,
                        ),
                      );
                    },
                    label: data == null
                        ? "Check in"
                        : data.status == 1
                        ? "Check out"
                        : status == 2
                        ? "Kirim Alasan"
                        : "Check in",
                    isSemiBold: true,
                  ),
                ),
          SizedBox(
            height: 16.h,
          ),
        ],
      ),
    );
  }
}
