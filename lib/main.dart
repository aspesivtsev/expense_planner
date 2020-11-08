import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import './transaction.dart';

//initializeDateFormatting('ru_RU', Null);

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
      home: MyHomePage(title: 'Flutter App Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  final List<Transaction> transactions = [
    Transaction(
        id: 't1', title: 'Трусики', amount: 69.99, date: DateTime.now()),
    Transaction(
        id: 't2', title: 'Бухлишко', amount: 37.00, date: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 35,
        title: Text("Expense Planner"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
          Column(
            children: transactions.map((tx) {
              return Card(
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: tx.amount > 50
                                ? Colors.redAccent
                                : Colors.green,
                            width: 2),
                      ),
                      child: Text(
                        '₽ ' + tx.amount.toString(),
                        // or use interpolation if it is a dollar sign '\$ ${tx.amount}',
                        // or '\$ ' + tx.amount.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: (15),
                          color:
                              tx.amount > 50 ? Colors.redAccent : Colors.green,
                        ),
                      ),
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tx.title,
                          style: TextStyle(
                              shadows: [
                                Shadow(
                                  blurRadius: 7.0,
                                  color: Colors.grey[400],
                                  offset: Offset(1.0, 1.0),
                                ),
                              ],
                              fontWeight: FontWeight.bold,
                              fontSize: (15),
                              color: Colors.blue[900]),
                          textAlign: TextAlign.right,
                        ),
                        Text(
                          //the first variant is more customizable
                          //https://api.flutter.dev/flutter/intl/DateFormat-class.html
                          //DateFormat('d MMMM y H:mm').format(tx.date),
                          DateFormat.yMMMMEEEEd().format(tx.date),

                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
