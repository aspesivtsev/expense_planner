import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'models/transaction.dart';

void main() {
  //initializeDateFormatting('ru', null).then((_) => (MyApp()));
  initializeDateFormatting().then((_) => runApp(MyApp()));
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
  //MyHomePage({Key key, this.title}) : super(key: key);
  //final String title;
  DateFormat dateFormat;
  DateFormat timeFormat;
  final List<Transaction> transactions = [
    Transaction(id: 't1', title: 'Отель', amount: 59.99, date: DateTime.now()),
    Transaction(
        id: 't2',
        title: 'Канатная дорога',
        amount: 37.00,
        date: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    //initializeDateFormatting();
    dateFormat = new DateFormat.yMMMMEEEEd('ru');
    timeFormat = new DateFormat.Hm('ru');

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 35,
        title: Text("Expense Planner"),
      ),
      body: Column(
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
          Column(
            children: transactions.map((tx) {
              String day = dateFormat.format(tx.date).toUpperCase();
              return Card(
                child: Row(
                  children: [
                    Container(
                      width: 100,
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
                          //DateFormat.yMMMMEEEEd().format(tx.date),
                          dateFormat.format(tx.date),
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          //the first variant is more customizable
                          //https://api.flutter.dev/flutter/intl/DateFormat-class.html
                          //DateFormat('d MMMM y H:mm').format(tx.date),
                          //DateFormat.yMMMMEEEEd().format(tx.date),
                          day,
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          timeFormat.format(tx.date),
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
