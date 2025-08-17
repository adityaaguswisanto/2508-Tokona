import 'package:tokona/packages/packages.dart';

class PromoDiscount extends StatelessWidget {
  final TextEditingController discount;

  const PromoDiscount({
    super.key,
    required this.discount,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: discount,
      style: Texts.medium(),
      cursorColor: orange,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.number,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        Currencies(),
      ],
      decoration: InputDecoration(
        hintText: "Harga Diskon",
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
            color: orange,
            width: 1,
          ),
        ),
      ),
    );
  }
}
