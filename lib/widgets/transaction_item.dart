import 'dart:math';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor;

  @override
  void initState() {
    const availableColors = [
      Colors.amber,
      Colors.green,
      Colors.blueAccent,
      Colors.red,
      Colors.purple,
      Colors.pink
    ];
    _bgColor = availableColors[Random().nextInt(6)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: FittedBox(
              child: Text(
                '₽ ' +
                    widget.transaction.amount
                        .toStringAsFixed(0), //number shows decimals
                // or use interpolation if it is a dollar sign '\$ ${tx.amount}',
                // or '\$ ' + tx.amount.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: (14),
                  color: widget.transaction.amount > 2000
                      ? Colors.redAccent[400]
                      : Theme.of(context).primaryColorLight,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMMEEEEd('ru').format(widget.transaction.date),
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
                onPressed: () => widget.deleteTx(widget.transaction.id),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => widget.deleteTx(widget.transaction.id),
              ),
      ),
    );
  }
}
