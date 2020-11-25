import 'package:flutter/material.dart';
import 'dart:math';
import './new_transaction.dart';
import './transaction_list.dart';
import '../models/transaction.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: 't1',
        title: 'Проживание в отеле',
        amount: 6000.00,
        date: DateTime.now()),
    Transaction(
        id: 't2',
        title: 'Завтрак',
        amount: 1100.00,
        date: DateTime.parse("2020-11-15 11:30")),
    Transaction(
        id: 't3',
        title: 'Чаевые',
        amount: 600.00,
        date: DateTime.parse("2020-11-14 09:00")),
  ];

  void _addNewTransaction(String txTitle, double txAmount) {
    Random random = new Random();
    final String rnd = random
        .nextInt(100)
        .toString(); //generating a random number to add to id^ to make it unique together with timestamp
    print(rnd);
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: DateTime.now(),
        id: DateTime.now().toString() + rnd);
    print(DateTime.now().toString() + rnd);
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(_addNewTransaction),
        TransactionList(_userTransactions),
      ],
    );
  }
}
