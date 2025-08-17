import 'package:tokona/packages/packages.dart';

class Buttons extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double borderRadius;
  final Color? fontColor;
  final double fontSize;
  final bool isBold;
  final bool isMedium;
  final bool isSemiBold;

  const Buttons({
    super.key,
    required this.onPressed,
    required this.label,
    this.backgroundColor,
    this.foregroundColor = transparent,
    this.borderRadius = 8.0,
    this.fontColor = white,
    this.fontSize = 12.0,
    this.isBold = false,
    this.isSemiBold = false,
    this.isMedium = true,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? orange,
        foregroundColor: foregroundColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderRadius.r,
          ),
        ),
      ),
      child: Text(
        label,
        style: textStyle(),
        textAlign: TextAlign.center,
      ),
    );
  }

  TextStyle textStyle() {
    if (isBold) {
      return Texts.bold(
        fontSize: fontSize.sp,
        color: fontColor,
      );
    } else if (isSemiBold) {
      return Texts.semiBold(
        fontSize: fontSize.sp,
        color: fontColor,
      );
    } else if (isMedium) {
      return Texts.medium(
        fontSize: fontSize.sp,
        color: fontColor,
      );
    } else {
      return Texts.regular(
        fontSize: fontSize.sp,
        color: fontColor,
      );
    }
  }
}

class ButtonsClose extends StatelessWidget {
  final VoidCallback? onPressed;
  final double size;
  final Color color;
  final bool disabled;

  const ButtonsClose({
    super.key,
    this.onPressed,
    this.size = 30,
    this.color = black,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      style: const ButtonStyle(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: disabled ? null : onPressed,
      icon: Icon(
        Icons.close,
        size: size,
        color: color,
      ),
    );
  }
}
