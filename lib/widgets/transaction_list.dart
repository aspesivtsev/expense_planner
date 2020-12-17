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
    initializeDateFormatting('ru');
    dateFormat = new DateFormat.yMMMMEEEEd('ru');
    timeFormat = new DateFormat.Hm('ru');

    return Container(
      height: 300,
      child: SafeArea(
        child: transactions.isEmpty
            ? Column(
                children: <Widget>[
                  Text(
                    'Записей пока нет!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              )
            : ListView(
                children: transactions.map((tx) {
                  String day = dateFormat.format(tx.date).toUpperCase();
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Text(
                        '₽ ' +
                            tx.amount
                                .toStringAsFixed(2), //number shows decimals
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
                    ),
                  );
                }).toList(),
              ),
      ),
    );
  }
}
