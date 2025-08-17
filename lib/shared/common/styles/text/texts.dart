import 'package:tokona/packages/packages.dart';

class Texts {
  static TextStyle regular({
    double fontSize = 12.0,
    Color? color = black,
    double? letterSpacing,
    FontStyle? fontStyle,
  }) => TextStyle(
    color: color,
    fontFamily: ConstantsAssets.fontMontserratRegular,
    fontSize: fontSize.sp,
    letterSpacing: letterSpacing,
    fontStyle: fontStyle,
  );

  static TextStyle medium({
    double fontSize = 12.0,
    Color? color = black,
    double? letterSpacing,
    FontStyle? fontStyle,
  }) => TextStyle(
    color: color,
    fontFamily: ConstantsAssets.fontMontserratMedium,
    fontSize: fontSize.sp,
    letterSpacing: letterSpacing,
    fontStyle: fontStyle,
  );

  static TextStyle semiBold({
    double fontSize = 12.0,
    Color? color = black,
    double? letterSpacing,
    FontStyle? fontStyle,
  }) => TextStyle(
    color: color,
    fontFamily: ConstantsAssets.fontMontserratSemiBold,
    fontSize: fontSize.sp,
    letterSpacing: letterSpacing,
    fontStyle: fontStyle,
  );

  static TextStyle bold({
    double fontSize = 12.0,
    Color? color = black,
    double? letterSpacing,
    FontStyle? fontStyle,
  }) => TextStyle(
    color: color,
    fontFamily: ConstantsAssets.fontMontserratBold,
    fontSize: fontSize.sp,
    letterSpacing: letterSpacing,
    fontStyle: fontStyle,
  );

  static TextStyle l({
    double fontSize = 12.0,
    Color? color = black,
    double? letterSpacing,
    FontStyle? fontStyle,
  }) => TextStyle(
    color: color,
    fontFamily: ConstantsAssets.fontMochiyPopPoneRegular,
    fontSize: fontSize.sp,
    letterSpacing: letterSpacing,
    fontStyle: fontStyle,
  );
}
