import 'package:tokona/packages/packages.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final String description;
  final GestureTapCallback? onTap;

  const MenuItem({
    super.key,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Texts.bold(),
                ),
                Text(
                  description,
                  style: Texts.regular(),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 4.w,
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 1.w,
                horizontal: 16.w,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  16.r,
                ),
                border: Border.all(
                  width: 1.w,
                  color: orange,
                ),
              ),
              child: Text(
                "Pilih",
                style: Texts.medium(
                  color: orange,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
