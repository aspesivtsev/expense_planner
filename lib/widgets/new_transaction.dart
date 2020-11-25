import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import './user_transactions.dart';

class NewTransaction extends StatelessWidget {
  final Function addTx;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  NewTransaction(this.addTx);

  void submitData() {
    final enteredData = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredData.isEmpty || enteredAmount <= 0) {
      return;
    }

    addTx(enteredData, enteredAmount);
  }

  //String titleInput;
  //String amountInput;
  @override
  Widget build(BuildContext context) {
    return Card(
        //margin: EdgeInsets.all(10),
        elevation: 8,
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                controller: titleController,
                onSubmitted: (_) => submitData(),
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
                controller: amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => submitData(),
                inputFormatters: <TextInputFormatter>[
                  //FilteringTextInputFormatter.digitsOnly //without dot
                  FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                ],
                //onChanged: (val) => amountInput = val, //this is shorter variant but with 1 line only
              ),
              FlatButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(3.0)),
                  color: Colors.blue[100],
                  textColor: Colors.blue,
                  child: Text('Добавить'),
                  onPressed: () {
                    //print(titleInput);
                    //print(titleController.text);
                    //print(amountController.text);
                    submitData();
                  }),
            ],
          ),
        ));
  }
}
