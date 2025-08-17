import 'package:tokona/packages/packages.dart';

class Failures extends StatelessWidget {
  final String title;

  const Failures({
    super.key,
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
            const Icon(
              Icons.phonelink_erase_rounded,
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
