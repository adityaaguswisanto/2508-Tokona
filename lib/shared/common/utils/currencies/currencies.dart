import 'package:tokona/packages/packages.dart';

class Currencies extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }
    final newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    final value = int.tryParse(newText);
    if (value == null) return oldValue;
    final formatted = Formatters.idr(value);
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(
        offset: formatted.length,
      ),
    );
  }
}
