import 'package:tokona/packages/packages.dart';

class HomeAttendancesShimmer extends StatelessWidget {
  const HomeAttendancesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
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
              Shimmers(
                width: Sizes.width(context) * 0.2,
                height: 12.h,
              ),
            ],
          ),
        ),
        Shimmers(
          width: Sizes.width(context) * 0.3,
          height: Sizes.height(context) * 0.04,
        ),
      ],
    );
  }
}
