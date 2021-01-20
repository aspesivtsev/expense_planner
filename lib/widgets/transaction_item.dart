import 'package:flutter/material.dart';
import '../models/transaction.dart';

import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: FittedBox(
              child: Text(
                '₽ ' +
                    transaction.amount
                        .toStringAsFixed(0), //number shows decimals
                // or use interpolation if it is a dollar sign '\$ ${tx.amount}',
                // or '\$ ' + tx.amount.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: (14),
                  color: transaction.amount > 2000
                      ? Colors.redAccent[400]
                      : Theme.of(context).primaryColorLight,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMMEEEEd('ru').format(transaction.date),
          style: Theme.of(context).textTheme.headline6,
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? FlatButton.icon(
                icon: const Icon(Icons.delete),
                label: const Text(
                  'Удалить',
                  style: TextStyle(fontSize: 10),
                ),
                textColor: Theme.of(context).errorColor,
                onPressed: () => deleteTx(transaction.id),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => deleteTx(transaction.id),
              ),
      ),
    );
  }
}
