import '../models/transaction.dart';
import 'package:flutter/material.dart';
//import './user_transactions.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class TransactionList extends StatelessWidget {
  DateFormat dateFormat;
  DateFormat timeFormat;
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    dateFormat = new DateFormat.yMMMMEEEEd('ru');
    timeFormat = new DateFormat.Hm('ru');

    return Container(
      height: 300,
      child: SafeArea(
        child: ListView(
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
                              ? Colors.red
                              : Theme.of(context).primaryColorDark,
                          width: 2),
                    ),
                    child: Text(
                      '₽ ' +
                          tx.amount.toStringAsFixed(2), //number shows decimals
                      // or use interpolation if it is a dollar sign '\$ ${tx.amount}',
                      // or '\$ ' + tx.amount.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: (14),
                        color: tx.amount > 2000
                            ? Colors.red
                            : Theme.of(context).primaryColorDark,
                      ),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tx.title,
                        style: Theme.of(context).textTheme.headline6,
                        /*
                        //old versio with manual coloring
                        TextStyle(
                            shadows: [
                              Shadow(
                                blurRadius: 7.0,
                                color: Colors.grey[400],
                                offset: Offset(1.0, 1.0),
                              ),
                            ],
                            //fontWeight: FontWeight.bold,
                            fontSize: (15),
                            color: Theme.of(context).primaryColorDark),*/
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
        ),
      ),
    );
  }
}
