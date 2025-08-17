import 'package:tokona/packages/packages.dart';

class LoginField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final String iconPath;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? onToggleVisibility;

  const LoginField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.iconPath,
    this.isPassword = false,
    this.obscureText = false,
    this.onToggleVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: Texts.medium(),
      cursorColor: orange,
      obscureText: isPassword ? obscureText : false,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: Texts.medium(
          color: black,
        ),
        labelText: label,
        labelStyle: Texts.medium(
          color: black,
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.all(
            12.r,
          ),
          child: SvgPicture.asset(
            iconPath,
          ),
        ),
        suffixIcon: isPassword
            ? IconButton(
                onPressed: onToggleVisibility,
                icon: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                  color: black,
                ),
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            8.r,
          ),
          borderSide: const BorderSide(
            color: black,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(
            color: orange,
            width: 1,
          ),
        ),
      ),
    );
  }
}
