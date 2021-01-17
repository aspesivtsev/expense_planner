import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'adaptive_button.dart';

//import 'package:flutter_localizations/flutter_localizations.dart';

//import './user_transactions.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredData = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredData.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return; //exiting ad skipping addTx
    }

    widget.addTx(enteredData, enteredAmount, _selectedDate);
    Navigator.of(context).pop(); //close modal form after entering data
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            locale: const Locale("ru"),
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('ru');
    return SingleChildScrollView(
      child: Card(
          //margin: EdgeInsets.all(1),
          elevation: 8,
          child: Container(
            padding: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom + 10),

            ///bottom controlling of modal window
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  controller: _titleController,
                  onSubmitted: (_) => _submitData(),
                  decoration: InputDecoration(labelText: 'Заголовок'),
                  //below is a manual equivalent of a controller, to process textinput
                  /*onChanged: (val) {
                          titleInput = val;
                          print(titleInput);
                        },*/
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Сумма'),
                  //keyboardType: TextInputType.number, //without a dot
                  controller: _amountController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  onSubmitted: (_) => _submitData(),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter
                        .digitsOnly, //keyboard without dot
                    //FilteringTextInputFormatter.allow(RegExp('[0-9.,]')), //keyboard with a dot
                  ],
                  //onChanged: (val) => amountInput = val, //this is shorter variant but with 1 line only
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(_selectedDate == null
                            ? 'Дата не выбрана'
                            : 'Выбранная дата: ${DateFormat.yMd('ru').format(_selectedDate)}'),
                      ),
                      AdaptiveFlatButton('Пососать член', _presentDatePicker),
                    ],
                  ),
                ),
                RaisedButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(3.0)),
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).textTheme.button.color,
                    child: Text('Добавить'),
                    onPressed: () {
                      //print(titleInput);
                      //print(titleController.text);
                      //print(amountController.text);
                      _submitData();
                    }),
              ],
            ),
          )),
    );
  }
}
