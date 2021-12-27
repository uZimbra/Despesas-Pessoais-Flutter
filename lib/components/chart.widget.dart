import 'package:expenses/components/chart-bar.widget.dart';
import 'package:expenses/models/transaction.model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartWidget extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const ChartWidget({Key? key, required this.recentTransactions})
      : super(key: key);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        bool sameDay = recentTransactions[i].date.day == weekDay.day;
        bool sameMoth = recentTransactions[i].date.month == weekDay.month;
        bool sameYear = recentTransactions[i].date.year == weekDay.year;

        if (sameDay && sameMoth && sameYear) {
          totalSum += recentTransactions[i].value;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': totalSum,
      };
    }).reversed.toList();
  }

  double get _weekTotalValue => groupedTransactions.fold(
        0,
        (previousValue, element) =>
            previousValue + (element['value'] as double),
      );

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions
              .map(
                (e) => Flexible(
                  fit: FlexFit.tight,
                  child: ChartBarWidget(
                    label: e['day'].toString(),
                    value: (e['value'] as double),
                    percentage: _weekTotalValue == 0
                        ? 0
                        : (e['value'] as double) / _weekTotalValue,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
