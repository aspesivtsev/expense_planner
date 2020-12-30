import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final String numDate;
  final double spendingAmount;
  final double speendingPctOfTotal;

  ChartBar(
      this.label, this.numDate, this.spendingAmount, this.speendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          height: 20,
          child:
              FittedBox(child: Text('₽${spendingAmount.toStringAsFixed(0)}'))),
      SizedBox(
        height: 4,
      ),
      Container(
        height: 60,
        width: 20,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                color: Color.fromRGBO(220, 220, 220, 1),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            FractionallySizedBox(
              heightFactor: speendingPctOfTotal,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(5)),
              ),
            ),
            SizedBox(
              height: 4,
            ),
          ],
        ),
      ),
      Text(label + ' ' + numDate),
    ]);
  }
}
