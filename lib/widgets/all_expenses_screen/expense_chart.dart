
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
          return list.isEmpty? const Center(child: Text('isEmpty!')):
          Column(
            children: [
              const Text('Show BarChart for Last Week'),
              const SizedBox(height: 5,),
              Expanded(
                child: BarChart(
                  BarChartData(
                    minY: 0,
                    maxY: maxY,
                    barGroups: [
                      ...list.map(
                            (e) => BarChartGroupData(
                          x: list.indexOf(e),
                          barRods: [
                              BarChartRodData(
                              color: Colors.blue,
                              toY: e['amount'],
                              width: 20.0,
                              borderRadius: BorderRadius.zero,
                            ),
                          ],
                        ),

                      ),
                    ],
                    titlesData: FlTitlesData(
                      topTitles: const AxisTitles(
                        drawBelowEverything: true,
                      ),
                      leftTitles: const AxisTitles(
                        drawBelowEverything: true,
                      ),
                      rightTitles: const AxisTitles(
                        drawBelowEverything: true,
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, _) => Text(DateFormat.E()
                                  .format(list[value.toInt()]['day'])),
                        ),
                      ),
                    ),
                ),
        ),
              ),
            ],
          );
      }
    );
  }
}

