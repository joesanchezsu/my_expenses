import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'expenses-model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'income.dart';
import 'money-flow.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() {
  final expenses = ExpensesModel();

  runApp(
    ScopedModel<ExpensesModel>(
      model: expenses,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ExpensesModel>(
      builder: (context, child, model) {
        return MaterialApp(
          title: 'My Expenses',
          theme: ThemeData.dark(),
          home: ExpensesList(),
        );
      },
    );
  }
}

class ExpensesList extends StatefulWidget {
  @override
  _ExpensesList createState() => _ExpensesList();
}

class _ExpensesList extends State<ExpensesList> {
  // final _currentExpenses = <MoneyFlow>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  File jsonFile;
  Directory dir;
  String fileName = "data.json";
  bool fileExists = false;
  Map<String, dynamic> fileContent;

  @override
  void initState() {
    super.initState();
    getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = new File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync(); // can be .exists() for async
      print(jsonFile);
      if (fileExists) {
        this.setState(
            () => fileContent = jsonDecode(jsonFile.readAsStringSync()));
      }
    });
  }

  void createFile(
      Map<String, dynamic> content, Directory dir, String fileName) {
    File file = new File(dir.path + "/" + fileName);
    file.createSync();
    fileExists = true;
    file.writeAsStringSync(jsonEncode(content));
  }

  void writeFile(MoneyFlow flow) {
    Map<String, dynamic> content = jsonDecode(jsonEncode(flow));
    //print("content" + content.toString());
    if (fileExists) {
      Map<String, dynamic> jsonFileContent =
          jsonDecode(jsonFile.readAsStringSync());
      //print("jsonFileContent" + jsonFileContent.toString());
      jsonFileContent.addAll(content);
      print("jsonFileContent after" + jsonFileContent.toString());
      jsonFile.writeAsStringSync(jsonEncode(jsonFileContent));
    } else {
      print("File doesn't exist !");
      createFile(content, dir, fileName);
    }
    this.setState(() => fileContent = jsonDecode(jsonFile.readAsStringSync()));
  }

  // Aca de pronto solo necesito acceder sin rebuild
  Widget _buildExpenses() {
    return ScopedModelDescendant<ExpensesModel>(
      builder: (context, child, model) {
        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemBuilder: (context, i) {
            // if (i.isOdd) return Divider();
            // final index = i ~/ 2;
            return _buildRow(model.flows[i]);
          },
          itemCount: model.flows.length,
        );
      },
    );
  }

  Widget _buildRow(MoneyFlow flow) {
    return ListTile(
      title: Text(
        flow.title,
        style: _biggerFont,
      ),
      trailing: Text(
        flow.amount.toString() + "€",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ExpensesModel>(
      builder: (context, child, model) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Don\'t spend on bullshit"),
          ),
          body: _buildExpenses(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              MoneyFlow income =
                  new Income("polas", "RESTAURANT", DateTime.now(), 10);
              model.add(income);
              writeFile(income);
              // print(model.toString());
              // String json = jsonEncode(income);
              // print(json);
            },
            child: Icon(Icons.add),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        );
      },
    );
  }
}
