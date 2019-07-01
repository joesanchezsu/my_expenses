import 'package:flutter/material.dart';
import 'package:my_expenses/components/fancy_fab.dart';
import 'package:provider/provider.dart';
import 'package:my_expenses/models/flow_model.dart';

class MyFlow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Don\'t spend on bullshit'),
        // style: Theme.of(context).textTheme.display4),
        // backgroundColor: Colors.white,
      ),
      body: Container(
        // color: Colors.yellow,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: _ExpensesList(),
              ),
            ),
            Container(height: 4, color: Colors.black),
            _TotalBalance(),
          ],
        ),
      ),
      floatingActionButton: FancyFab(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => Navigator.pushReplacementNamed(context, '/categories'),
      //   backgroundColor: Colors.white,
      //   child: Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class _ExpensesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme.title;
    var cart = Provider.of<FlowModel>(context);

    return ListView(
      children: [
        for (var item in cart.items) Text('· ${item.name}', style: textTheme),
      ],
    );
  }
}

class _TotalBalance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme.display4.copyWith(fontSize: 48);

    return SizedBox(
      height: 200,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<FlowModel>(
                builder: (context, cart, child) =>
                    Text('\$${cart.totalPrice}', style: textTheme)),
            SizedBox(width: 24),
          ],
        ),
      ),
    );
  }
}
