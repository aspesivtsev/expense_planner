import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final String numDate;
  final double spendingAmount;
  final double speendingPctOfTotal;

  const ChartBar(
      this.label, this.numDate, this.spendingAmount, this.speendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      ///LayoutBuilder is used to get parent height and use it to stretch bars to its height dynamicly
      builder: (ctx, constraints) {
        return Column(children: [
          Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                  child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text('₽${spendingAmount.toStringAsFixed(0)}'),
              ))),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.6,
            width: 20,
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).primaryColorDark, width: 1.0),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: speendingPctOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        //color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.05,
                ),
              ],
            ),
          ),
          Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                  child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(label + ' ' + numDate),
              ))),
        ]);
      },
    );
  }
}
