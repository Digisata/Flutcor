import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class NumberHelper {
  static String format(String number) {
    return FlutterMoneyFormatter(amount: double.parse(number))
        .output
        .withoutFractionDigits;
  }
}
