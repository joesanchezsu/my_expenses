import 'package:intl/intl.dart';

class MoneyFlow {
  final String title;
  final String group;
  final DateTime date;
  final String type;
  final double amount;

  MoneyFlow(this.title, this.group, this.date, this.type, this.amount);

  MoneyFlow.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        group = json['group'],
        date = DateTime.parse(json['date']),
        type = json['type'],
        amount = json['amount'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'group': group,
        'date': DateFormat('dd/MM/yyyy').format(date),
        'type': type,
        'amount': amount,
      };

  // String get title => _title;
  // String get group => _group;
  // DateTime get date => _date;
  // String get type => _type;
  // double get amount => _amount;

  // void f();

  @override
  String toString() {
    return "title: " + title + "amount" + amount.toString();
  }
}
