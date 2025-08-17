import 'package:tokona/packages/packages.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          ConstantsAssets.imgLogoWhite,
          width: 30.w,
          height: 30.h,
        ),
        SizedBox(
          width: 8.h,
        ),
        Text(
          "Tokona",
          style: Texts.l(
            fontSize: 20.sp,
            color: white,
          ),
        ),
      ],
    );
  }
}
