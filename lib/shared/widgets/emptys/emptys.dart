import 'package:tokona/packages/packages.dart';

class Emptys extends StatelessWidget {
  final IconData iconData;
  final String title;

  const Emptys({
    super.key,
    required this.iconData,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(
        16.r,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 60,
              color: black,
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              title,
              style: Texts.medium(
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
