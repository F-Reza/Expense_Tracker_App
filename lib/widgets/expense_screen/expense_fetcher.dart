
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/expense_provider.dart';
import '../all_expenses_screen/expense_chart.dart';
import 'expense_list.dart';

class ExpenseFetcher extends StatefulWidget {
  const ExpenseFetcher(this.category, {super.key});
  final String category;

  @override
  State<ExpenseFetcher> createState() => _ExpenseFetcherState();
}

class _ExpenseFetcherState extends State<ExpenseFetcher> {

  late Future _expenseList;
  Future _getExpenseList() async {
    final provider = Provider.of<ExpenseProvider>(context, listen: false);
    return await provider.getExpense(widget.category);
  }

  @override
  void initState() {
    _expenseList = _getExpenseList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:_expenseList,
      builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Center(child: Text('Failed to fetch data'));
          } else {
            final provider = Provider.of<ExpenseProvider>(context, listen: false);
            var expList = provider.expenseList;
            return Column(
              children: [
                  expList.isEmpty? const SizedBox():
                Card(
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFFCCCCFF),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade500,
                              offset: const Offset(4, 4),
                              blurRadius: 15,
                              spreadRadius: 1
                          ),
                          const BoxShadow(
                              color: Colors.white,
                              offset: Offset(-4, -4),
                              blurRadius: 15,
                              spreadRadius: 1
                          ),
                        ]
                    ),
                    height: 250,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ExpenseChart(widget.category),
                    ),
                  ),
                ),
                const Expanded(child: ExpenseList()),
              ],
            );
          }
        } else {
          return const CircularProgressIndicator();
        }
      }
    );
  }
}
