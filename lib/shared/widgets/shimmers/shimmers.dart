import 'package:tokona/packages/packages.dart';

class Shimmers extends StatelessWidget {
  final double width;
  final double height;
  final bool withCircle;
  final double borderRadius;
  final Color baseColor;
  final Color highlightColor;

  const Shimmers({
    super.key,
    required this.width,
    required this.height,
    this.withCircle = false,
    this.borderRadius = 8.0,
    this.baseColor = black300,
    this.highlightColor = black400,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        width: width.w,
        height: height.h,
        decoration: BoxDecoration(
          color: black600,
          shape: withCircle ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: withCircle
              ? null
              : BorderRadius.circular(
                  borderRadius.r,
                ),
        ),
      ),
    );
  }
}
