import 'package:intl/intl.dart';

class CurrencyFormatter {
  static String format(double amount) {
    final NumberFormat currencyFormat = NumberFormat.currency(
      locale: 'en_NG',
      symbol: '₦',
      decimalDigits: 0,
    );
    return currencyFormat.format(amount);
  }
}