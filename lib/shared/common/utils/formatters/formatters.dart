import 'package:tokona/packages/packages.dart';

class Formatters {
  static String idr(dynamic number, {int? decimalDigit}) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp',
      decimalDigits: decimalDigit ?? 0,
    );
    return currencyFormatter.format(number);
  }
}
