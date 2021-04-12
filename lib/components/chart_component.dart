import 'package:dispesas/components/chart_bar.dart';
import 'package:dispesas/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartComponent extends StatelessWidget {
  final List<TransactionModel> recentTrasaction;

  ChartComponent(this.recentTrasaction);

  List<Map<String, Object>> get groupedTrasaction {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0.0;

      for (int i = 0; i < recentTrasaction.length; i++) {
        bool sameDay = recentTrasaction[i].date.day == weekDay.day;
        bool sameMoth = recentTrasaction[i].date.month == weekDay.month;
        bool sameyear = recentTrasaction[i].date.year == weekDay.year;

        if (sameDay && sameMoth && sameyear) {
          totalSum += recentTrasaction[i].price;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': totalSum,
      };
    }); //.reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTrasaction.fold(0.0, (sum, tr) {
      return sum + tr['value'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTrasaction.map((tr) {
              return Expanded(
                child: ChartBar(
                  label: tr['day'],
                  price: tr['value'],
                  percentage: _weekTotalValue == 0
                      ? 0
                      : (tr['value'] as double) / _weekTotalValue,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
