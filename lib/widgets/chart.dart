import 'chart_bar.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      //print(DateFormat.E().format(weekDay));
      //print(totalSum);
      return {
        'day': DateFormat.E('ru').format(weekDay).substring(0, 2),
        'amount': totalSum,
        'date': DateFormat.d('ru').format(weekDay),
      };
    }).reversed.toList();
  }

  double get totalSpending {
    //fold функция которая список переводит в другой формат, где над каждым элементом списка производится какое-то действие
    //также задается начальное значение 0.0, в данном случае суммируются элементы (видео из секции 102)
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      color: Theme.of(context).primaryColorLight,
      child: Container(
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  data['day'],
                  data['date'],
                  data['amount'],
                  totalSpending == 0.0
                      ? 0.0
                      : (data['amount'] as double) / totalSpending),
            );
            //Text('${data['day']} : ${data['amount'].toString()}');
          }).toList(),
        ),
      ),
    );
  }
}
