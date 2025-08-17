import 'package:tokona/packages/packages.dart';

class Dates {
  static String formatDate(String dateTime, {String? format}) {
    return DateFormat(
      format ?? "dd MMMM yyyy, HH:mm:ss",
      "id_ID",
    ).format(DateTime.parse(dateTime).toLocal());
  }
}
