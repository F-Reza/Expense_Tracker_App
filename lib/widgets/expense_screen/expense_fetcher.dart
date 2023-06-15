import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/expense_provider.dart';
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
            return const ExpenseList();
          }
        } else {
          return const CircularProgressIndicator();
        }
      }
    );
  }
}
