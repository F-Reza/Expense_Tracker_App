import 'package:expense_tracker_app/provider/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(
        builder: (context, provider, _) {
          var exList = provider.expenseList;
          return exList.isEmpty ?
          const Center(child: Text('isEmpty')):
          ListView.builder(
            itemCount: exList.length,
            itemBuilder: (context, i) => Card(
              elevation: 1,
              child: ListTile(
                title: Text(exList[i].title),
                subtitle: Text(exList[i].date.toString()),
                trailing: Text('৳ ${exList[i].amount.toStringAsFixed(2)}'),
              ),
            ),
          );
        },
    );
  }
}
