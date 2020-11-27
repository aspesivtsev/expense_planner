//import 'package:expense_planner/widgets/new_transaction.dart';
import 'package:flutter/material.dart';

import './widgets/user_transactions.dart';

//initializeDateFormatting('ru', Null);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 35,
        title: Text(
          "планировщик расходов".toUpperCase(),
          style: TextStyle(fontSize: 17),
        ),
      ),
      //in body we can wrapp it all to SingleChildScrollView() to make the whole body of the app scrollable on the screen
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                child: Text(
                  "CHART!",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                elevation: 8,
                color: Colors.amber,
              ),
            ),
            UserTransactions(),
          ],
        ),
      ),
    );
  }
}
