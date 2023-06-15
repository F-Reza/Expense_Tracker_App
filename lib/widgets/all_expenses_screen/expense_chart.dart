
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/expense_provider.dart';

class ExpenseChart extends StatefulWidget {
  const ExpenseChart(this.category, {super.key});
  final String category;

  @override
  State<ExpenseChart> createState() => _ExpenseChartState();
}

class _ExpenseChartState extends State<ExpenseChart> {
  @override
  Widget build(BuildContext context) {
  return Consumer<ExpenseProvider>(
        builder: (context, provider, _) {
          var maxY = provider.calculateEntriesAndAmount(widget.category)['totalAmount'];
          var list = provider.calculateWeekExpenses().reversed.toList();
          return BarChart(
            BarChartData(
              minY: 0,
              maxY: maxY,
              barGroups: [
                ...list.map(
                      (e) => BarChartGroupData(
                    x: list.indexOf(e),
                    barRods: [
                      BarChartRodData(
                        toY: e['amount'],
                        width: 20.0,
                        borderRadius: BorderRadius.zero,
                      ),
                    ],
                  ),
                ),
              ],
          ),
        );
      }
    );
  }
}

