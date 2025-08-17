import 'package:tokona/packages/packages.dart';

class InventorySearch extends StatelessWidget {
  final TextEditingController search;
  final ValueChanged<String>? onFieldSubmitted;

  const InventorySearch({
    super.key,
    required this.search,
    required this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 16.h,
        left: 16.w,
        right: 16.w,
      ),
      child: TextFormField(
        controller: search,
        autofocus: true,
        style: Texts.medium(),
        cursorColor: orange,
        textInputAction: TextInputAction.go,
        keyboardType: TextInputType.text,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onFieldSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
          filled: true,
          fillColor: white,
          hintText: "Cari nama toko atau kode toko",
          hintStyle: Texts.medium(
            color: black.withValues(
              alpha: 0.5,
            ),
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.all(
              16.r,
            ),
            child: SvgPicture.asset(
              ConstantsAssets.icSearch,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              16.r,
            ),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              16.r,
            ),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              16.r,
            ),
            borderSide: const BorderSide(
              color: black400,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
