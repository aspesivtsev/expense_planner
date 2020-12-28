import '../models/transaction.dart';
import 'package:flutter/material.dart';
//import './user_transactions.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class TransactionList extends StatelessWidget {
  DateFormat dateFormat;
  DateFormat timeFormat;
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('ru');
    dateFormat = new DateFormat.yMMMMEEEEd('ru');
    timeFormat = new DateFormat.Hm('ru');
    double scrHeight = MediaQuery.of(context).size.height;

    return Container(
      height: scrHeight - 220,
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
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(3),
                          child: FittedBox(
                            child: Text(
                              '₽ ' +
                                  tx.amount.toStringAsFixed(
                                      0), //number shows decimals
                              // or use interpolation if it is a dollar sign '\$ ${tx.amount}',
                              // or '\$ ' + tx.amount.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: (14),
                                color: tx.amount > 2000
                                    ? Colors.redAccent[400]
                                    : Theme.of(context).primaryColorLight,
                              ),
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        tx.title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMMEEEEd('ru').format(tx.date),
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                        onPressed: () => deleteTx(tx.id),
                      ),
                    ),
                  );
                }).toList(),
              ),
      ),
    );
  }
}
