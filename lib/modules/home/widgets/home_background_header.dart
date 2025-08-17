import 'package:tokona/packages/packages.dart';

class HomeBackgroundHeader extends StatelessWidget {
  const HomeBackgroundHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Sizes.width(context),
      height: Sizes.height(context) * 0.218,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(
            50.r,
          ),
          bottomRight: Radius.circular(
            50.r,
          ),
        ),
        color: orange,
      ),
    );
  }
}
