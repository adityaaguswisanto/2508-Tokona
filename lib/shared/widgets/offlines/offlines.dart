import 'package:tokona/packages/packages.dart';

class Offlines extends StatelessWidget {
  const Offlines({super.key});

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
              Icons.connect_without_contact,
              size: 60,
              color: black,
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              "Tidak ada internet",
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
