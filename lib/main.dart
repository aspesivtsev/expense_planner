//import 'package:expense_planner/widgets/new_transaction.dart';
import 'package:flutter/material.dart';
import './models/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import 'dart:math';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
//initializeDateFormatting('ru', Null);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ru'),
      ],
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.blue[900],
        errorColor: Colors.redAccent[400],
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
            ),
            button: TextStyle(color: Colors.white)),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                //fontWeight: FontWeight.bold,
              )),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    /*Transaction(
        id: 't1',
        title: 'Проживание в отеле',
        amount: 6000.00,
        date: DateTime.now()),
    Transaction(
        id: 't2',
        title: 'Завтрак',
        amount: 1100.00,
        date: DateTime.parse("2020-12-08 11:30")),
    Transaction(
        id: 't3',
        title: 'Чаевые',
        amount: 600.00,
        date: DateTime.parse("2020-12-07 09:00")),*/
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    Random random = new Random();
    final String rnd = random
        .nextInt(100)
        .toString(); //generating a random number to add to id^ to make it unique together with timestamp
    //print(rnd);

    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: chosenDate,
        id: DateTime.now().toString() + rnd);

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);

      /// or longer variant, this is equivalent
      /// _userTransactions.removeWhere((tx){return tx.id == id;});
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    ///this is starting the modal popup form for entering data for a new transaction
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap:
              () {}, //disable modal window form closing when tapping on a white space below the form
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      centerTitle: true,
      toolbarHeight: 35,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        )
      ],
      title: Text(
        "планировщик расходов".toUpperCase(),
        style: TextStyle(fontSize: 17),
      ),
    );
    initializeDateFormatting('ru');
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        ///in body we can wrapp it all to SingleChildScrollView() to make the whole body of the app scrollable on the screen
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.3,

              ///0.3 means 20% of the screen height
              width: double.infinity,
              child: Chart(_recentTransactions),
            ),
            Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.7,

                ///0.7 means 80% of the screen height
                child: TransactionList(_userTransactions, _deleteTransaction)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
