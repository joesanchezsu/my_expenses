import 'package:flutter/material.dart';
import 'package:my_expenses/screens/categories_out.dart';
import 'package:my_expenses/screens/login.dart';
import 'package:provider/provider.dart';
import 'package:my_expenses/models/flow_model.dart';
import 'package:my_expenses/screens/flow.dart';
import 'package:my_expenses/screens/categories_in.dart';
// import 'package:my_expenses/screens/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => FlowModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        // theme: ThemeData(
        //   primarySwatch: Colors.yellow,
        //   textTheme: TextTheme(
        //     display4: TextStyle(
        //       fontFamily: 'Corben',
        //       fontWeight: FontWeight.w700,
        //       fontSize: 24,
        //       color: Colors.black,
        //     ),
        //   ),
        // ),
        initialRoute: '/',
        routes: {
          '/': (context) => MyFlow(),
          '/categories_in': (context) => MyCategoriesIn(),
          '/categories_out': (context) => MyCategoriesOut(),
          // '/description': (context) => DescriptionForm(),
        },
      ),
    );
  }
}
