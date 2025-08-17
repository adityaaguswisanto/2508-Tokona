import 'package:tokona/packages/packages.dart';

class AttendancesDropdown extends StatelessWidget {
  final List<String> items;
  final String? value;
  final ValueChanged<String?> onChanged;
  final String hintText;

  const AttendancesDropdown({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.hintText = "Pilih kondisi",
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        fillColor: white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            8.r,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 8.h,
        ),
      ),
      dropdownColor: white,
      hint: Text(
        hintText,
        style: Texts.medium(),
      ),
      value: value,
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(
            item,
            style: Texts.medium(),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
