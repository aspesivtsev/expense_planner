import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import './transaction.dart';

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
  //MyHomePage({Key key, this.title}) : super(key: key);
  //final String title;

  final List<Transaction> transactions = [
    Transaction(
        id: 't1',
        title: 'Проживание в отеле',
        amount: 6000.00,
        date: DateTime.now()),
    Transaction(
        id: 't2', title: 'Завтрак', amount: 1100.00, date: DateTime.now()),
    Transaction(
        id: 't2',
        title: 'Чаевые',
        amount: 600.00,
        date: DateTime.parse("2020-11-14 09:00")),
  ];

  @override
  //initializeDateFormatting();

  DateFormat dateFormat;
  DateFormat timeFormat;

  Widget build(BuildContext context) {
    initializeDateFormatting();
    dateFormat = new DateFormat.yMMMMEEEEd('ru');
    timeFormat = new DateFormat.Hm('ru');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 35,
        title: Text(
          "планировщик расходов".toUpperCase(),
          style: TextStyle(fontSize: 17),
        ),
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
          Card(
              //margin: EdgeInsets.all(10),
              elevation: 8,
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: 'Заголовок'),
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Сумма'),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                    FlatButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0)),
                        color: Colors.blue[100],
                        textColor: Colors.blue,
                        child: Text('Добавить'),
                        onPressed: () {}),
                  ],
                ),
              )),
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
                            color: tx.amount > 2000
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
                          color: tx.amount > 2000
                              ? Colors.redAccent
                              : Colors.green,
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
                          dateFormat.format(
                              tx.date), //we can add .toUpperCase for example
                          style: TextStyle(color: Colors.grey),
                        ),
                        //если нужно выделить отдельно год например и совместить с текстом
                        //Text("Year ${tx.date.year.toString()}"),
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
