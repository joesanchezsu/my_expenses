import 'money-flow.dart';

class Income extends MoneyFlow {
  Income(String title, String group, DateTime date, double amount)
      : super(title, group, date, "income", amount);
}
