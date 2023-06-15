import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/expense_model.dart';
import '../../provider/expense_provider.dart';

class ExpenseFetcher extends StatefulWidget {
  const ExpenseFetcher({super.key});

  @override
  State<ExpenseFetcher> createState() => _ExpenseFetcherState();
}

class _ExpenseFetcherState extends State<ExpenseFetcher> {

  Future _getExpenseList() async {
    final provider = Provider.of<ExpenseProvider>(context, listen: false);
    return await provider.getAllExpense('Transport');
    //return await provider.getExpensesByTitle('Transport');
  }

  @override
  void initState() {
    _getExpenseList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ExpenseProvider>(context, listen: false);
    return ListView.builder(
        itemCount: provider.expenseList.length,
        itemBuilder: (context, index) {
          final model = provider.expenseList[index];
          print('-------$model');
          return Card(
            elevation: 5,
            color: Colors.white70,
            child: ListTile(
              title: Text(model.category,
                  style: const TextStyle(fontSize: 16, color: Colors.blue)),
            ),
          );
        });
    /*return FutureBuilder<Expense>(
        future: provider.getExpensesByTitle('title'),
        builder: (context, snapshot){
          if(snapshot.hasData) {
            final model = snapshot.data;
            return Card(
              child: ListTile(
                title: Text(model!.title),
                ),
              );
          }
          if(snapshot.hasError){
            return const Center(child: Text('Failed to fetch data'));
          }
          return const CircularProgressIndicator();
        },
      );*/

  }
}
