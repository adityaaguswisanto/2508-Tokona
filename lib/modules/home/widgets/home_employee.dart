import 'package:tokona/packages/packages.dart';

class HomeEmployee extends StatelessWidget {
  final String nik;
  final String name;
  final String position;
  final String createdAt;

  const HomeEmployee({
    super.key,
    required this.nik,
    required this.name,
    required this.position,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          ConstantsAssets.imgAvatar,
        ),
        SizedBox(
          width: 8.w,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Texts.bold(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "$nik - $position",
                style: Texts.regular(),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 8.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "Member Since",
              style: Texts.bold(),
            ),
            Text(
              createdAt.isEmpty
                  ? ""
                  : Dates.formatDate(createdAt, format: "dd MMMM yyyy"),
              style: Texts.regular(),
            ),
          ],
        ),
      ],
    );
  }
}
