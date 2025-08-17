import 'package:tokona/packages/packages.dart';

class PromoEndDate extends StatelessWidget {
  final TextEditingController endDate;
  final GestureTapCallback? onTap;

  const PromoEndDate({
    super.key,
    required this.endDate,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: endDate,
      style: Texts.medium(),
      cursorColor: orange,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      readOnly: true,
      onTap: onTap,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: "Tanggal Akhir Diskon",
        hintStyle: Texts.medium(
          color: black600,
        ),
        labelStyle: Texts.medium(
          color: black600,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            8.r,
          ),
          borderSide: const BorderSide(
            color: black600,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            8.r,
          ),
          borderSide: const BorderSide(
            color: black600,
            width: 1,
          ),
        ),
      ),
    );
  }
}
