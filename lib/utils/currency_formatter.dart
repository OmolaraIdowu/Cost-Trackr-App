import 'package:cost_trackr/utils/enums.dart';
import 'package:intl/intl.dart';

class CurrencyFormatter {
  static final Map<Currency, NumberFormat> _currencyFormatters = {
    Currency.eur: NumberFormat.currency(symbol: '€', decimalDigits: 0),
    Currency.usd: NumberFormat.currency(symbol: '\$', decimalDigits: 0),
    Currency.ngn: NumberFormat.currency(symbol: '₦', decimalDigits: 0),
    Currency.gbp: NumberFormat.currency(symbol: '£', decimalDigits: 0),
    // Add other currencies as needed
  };

  // Format currency based on the selected currency
  static String _formatCurrency(double amount, Currency currency) {
    return _currencyFormatters[currency]?.format(amount) ?? amount.toString();
  }

  String formatCurrency(double amount) {
    return NumberFormat.currency(symbol: 'N ', decimalDigits: 0).format(amount);
  }
}
