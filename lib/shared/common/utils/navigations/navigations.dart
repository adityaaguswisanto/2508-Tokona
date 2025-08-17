import 'package:tokona/packages/packages.dart';

class Navigations {
  static back(BuildContext context) => Navigator.pop(context);

  static go(
    BuildContext context,
    String nameRouted, {
    Object? arguments,
  }) => Navigator.pushNamed(
    context,
    nameRouted,
    arguments: arguments,
  );

  static goRemoveUntil(
    BuildContext context,
    String nameRouted, {
    Object? arguments,
  }) =>
      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil(
        nameRouted,
        (route) => false,
        arguments: arguments,
      );
}
