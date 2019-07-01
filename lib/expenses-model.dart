import 'package:collection/collection.dart';
import 'package:scoped_model/scoped_model.dart';
import 'money-flow.dart';

class ExpensesModel extends Model {
  List<MoneyFlow> _flows = [];

  ExpensesModel();

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<MoneyFlow> get flows => UnmodifiableListView(_flows);

  set flows(List<MoneyFlow> flows) {
    _flows = flows;
  }

  void add(MoneyFlow flow) {
    _flows.add(flow);
    // This call tells [Model] that it should rebuild the widgets that depend on it.
    notifyListeners();
  }

  ExpensesModel.fromJson(Map<String, dynamic> json) : _flows = json['flows'];

  Map<String, dynamic> toJson() =>
      {'flows': _flows.map((i) => i.toJson()).toList()};

  @override
  String toString() {
    String str = "";
    _flows.forEach((flow) => str = str + flow.toString() + "\n");
    return str;
  }
}
