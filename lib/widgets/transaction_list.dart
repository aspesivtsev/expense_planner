import '../models/transaction.dart';
import './transaction_item.dart';
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
    //double scrHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    'Записей пока нет!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.7,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            })
          : ListView(
              children: transactions.map((tx) {
                String day = dateFormat.format(tx.date).toUpperCase();
                return TransactionItem(
                    key:
                        //UniqueKey(), //unique key makes every item to get random color every time the list changes
                        ValueKey(tx.id),
                    transaction: tx,
                    deleteTx: deleteTx);
              }).toList(),
            ),
    );
  }
}
