import 'package:tokona/packages/packages.dart';

class AttendancesRadio extends StatelessWidget {
  final int value;
  final String title;
  final int status;
  final ValueChanged<int?>? onChanged;

  const AttendancesRadio({
    super.key,
    required this.value,
    required this.title,
    required this.status,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RadioListTile<int>(
        contentPadding: EdgeInsets.zero,
        value: value,
        title: Text(
          title,
          style: Texts.medium(),
        ),
        groupValue: status,
        onChanged: onChanged,
      ),
    );
  }
}
