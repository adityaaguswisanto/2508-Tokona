import 'package:tokona/packages/packages.dart';

class Cards extends StatelessWidget {
  final GestureTapCallback? onTap;
  final bool? withBorder;
  final bool? withRipple;
  final double? radius;
  final Widget child;
  final double? elevation;

  const Cards({
    super.key,
    this.onTap,
    this.withBorder,
    required this.child,
    this.radius,
    this.withRipple,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: white,
      surfaceTintColor: white,
      shadowColor: black.withValues(
        alpha: 0.1,
      ),
      shape: RoundedRectangleBorder(
        side: withBorder == true
            ? BorderSide(
                color: orange.withValues(
                  alpha: 0.2,
                ),
              )
            : BorderSide.none,
        borderRadius: BorderRadius.circular(
          radius ?? 8,
        ),
      ),
      elevation: elevation ?? 6,
      child: withRipple == true
          ? InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  radius ?? 8,
                ),
              ),
              borderRadius: BorderRadius.circular(
                8,
              ),
              onTap: onTap,
              child: Padding(
                padding: EdgeInsets.all(
                  12.r,
                ),
                child: child,
              ),
            )
          : Padding(
              padding: EdgeInsets.all(
                12.r,
              ),
              child: child,
            ),
    );
  }
}
