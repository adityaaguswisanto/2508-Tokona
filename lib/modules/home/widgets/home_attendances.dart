import 'package:tokona/packages/packages.dart';

class HomeAttendances extends StatelessWidget {
  final AttendancesBloc attendancesBloc;
  final Attendances attendances;
  final String workingHours;

  const HomeAttendances({
    super.key,
    required this.attendancesBloc,
    required this.attendances,
    required this.workingHours,
  });

  @override
  Widget build(BuildContext context) {
    final status = attendances.data?.status;
    final reason = attendances.data?.reason;
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Working Hours",
                style: Texts.regular(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                status == 2 && reason == null
                    ? "00:00:00"
                    : status == 2 && reason != null
                    ? reason
                    : workingHours,
                style: Texts.bold(),
              ),
            ],
          ),
        ),
        SizedBox(
          width: Sizes.width(context) * 0.36,
          height: Sizes.height(context) * 0.03,
          child: Buttons(
            onPressed: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              enableDrag: false,
              isDismissible: false,
              backgroundColor: white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(
                    20.r,
                  ),
                ),
              ),
              builder: (context) => AttendancesModal(
                attendancesBloc: attendancesBloc,
                attendances: attendances,
              ),
            ),
            label: status == 1 ? "Check Out" : "Check In",
            fontSize: 10.sp,
            isSemiBold: true,
          ),
        ),
      ],
    );
  }
}
