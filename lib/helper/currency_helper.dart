import 'package:intl/intl.dart';

class CurrencyHelper {
  static String format(double value) {
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'id_ID');
    return formatCurrency.format(value);
  }
}
