import 'package:tokona/packages/packages.dart';

class Loadings extends StatelessWidget {
  final double width;
  final double height;

  const Loadings({
    super.key,
    this.width = 24.0,
    this.height = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      height: height.h,
      child: const CircularProgressIndicator(
        color: orange,
        strokeWidth: 3,
      ),
    );
  }
}
