import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../../provider/expense_provider.dart';

class TotalChart extends StatefulWidget {
  const TotalChart({super.key});

  @override
  State<TotalChart> createState() => _TotalChartState();
}

class _TotalChartState extends State<TotalChart> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(
        builder: (context, provider, _) {
        final list = provider.categories;
        final totalExp = provider.calculateTotalExpenses();
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Expanded(
                flex: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      alignment: Alignment.center,
                      fit: BoxFit.scaleDown,
                      child: Text('Total Expense: $totalExp',
                        textScaleFactor: 1.1,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          ),
                      ),
                    ),
                    const SizedBox(height: 5,),
                    ...list.map((e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            color: Colors.primaries[list.indexOf(e)],
                          ),
                          const SizedBox(width: 5,),
                          Text(e.title),
                          const SizedBox(width: 5,),
                          Text('${(e.totalAmount / totalExp * 100).toStringAsFixed(2)}%'),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
              Expanded(
                flex: 40,
                child: PieChart(
                  PieChartData(
                    centerSpaceRadius: 25.0,
                    sections: list.map((e) => PieChartSectionData(
                      showTitle: false,
                      value: e.totalAmount,
                      color: Colors.primaries[list.indexOf(e)],
                    )).toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
