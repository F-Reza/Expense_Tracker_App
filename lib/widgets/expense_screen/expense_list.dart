import 'package:expense_tracker_app/provider/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../constants/icons.dart';
import '../../models/expense_model.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(
        builder: (context, provider, _) {
          var exList = provider.expenseList;
          return exList.isEmpty ?
          const Center(child: Text('isEmpty!')):
          ListView.builder(
            itemCount: exList.length,
            itemBuilder: (context, i) => Card(
              elevation: 2,
              child: Dismissible(
                key: ValueKey(exList[i].id),
                direction: DismissDirection.endToStart,
                confirmDismiss: (_) async{
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete Expense'),
                      content: Text('Are you sure to delete this ${exList[i].title}?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('NO'),
                        ),
                        TextButton(
                          onPressed: () {
                            provider.deleteExpense(Expense(
                                id: exList[i].id,
                                title: exList[i].title,
                                amount: exList[i].amount,
                                date: exList[i].date,
                                category: exList[i].category)
                            );
                            //provider.deleteExpense(expList[i].id!, expList[i].title, expList[i].amount);
                            Navigator.pop(context, true);
                          },
                          child: const Text('YES'),
                        ),
                      ],
                    ),
                  );
                  return null;
                },
                onDismissed: (direction) {
                  //
                },
                background: Container(
                  padding: const EdgeInsets.only(right: 10),
                  color: Colors.red[300],
                  alignment: Alignment.centerRight,
                  child: const Icon(
                    Icons.delete,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                child: ListTile(
                  leading: Icon(icons[exList[i].category],size: 30,),
                  title: Text(exList[i].title),
                  subtitle: Text(DateFormat('dd, MMM, yyyy, hh:mm:a').format(exList[i].date)),
                  trailing: Text('৳ ${exList[i].amount.toStringAsFixed(2)}'),
                ),
              ),
            ),
          );
        },
    );
  }
}
