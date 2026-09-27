import 'package:intl/intl.dart';

class Formatters {
  Formatters._();

  static String currency(num value) {
    return NumberFormat.currency(
      symbol: '\$',
      decimalDigits: 0,
    ).format(value);
  }

  static String date(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }
}