import 'package:expense_tracker_app/constants/icons.dart';
import 'package:expense_tracker_app/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../provider/expense_provider.dart';

class AllExpensesList extends StatelessWidget {
  const AllExpensesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(
      builder: (context, provider, _) {
        var expList = provider.expenseList;
        return ListView.builder(
          itemCount: expList.length,
          itemBuilder: (context, i) => Card(
            elevation: 3,
            child: Dismissible(
              key: ValueKey(expList[i].id),
              direction: DismissDirection.endToStart,
              confirmDismiss: (_) async{
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete Expense'),
                    content: Text('Are you sure to delete this ${expList[i].title}?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('NO'),
                      ),
                      TextButton(
                        onPressed: () {
                          provider.deleteExpense(Expense(
                              id: expList[i].id,
                              title: expList[i].title,
                              amount: expList[i].amount,
                              date: expList[i].date,
                              category: expList[i].category)
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
                leading: Icon(icons[expList[i].category],size: 30,),
                title: Text(expList[i].title),
                subtitle: Text(DateFormat('dd, MMM, yyyy, hh:mm:a').format(expList[i].date)),
                trailing: Text('৳ ${expList[i].amount.toStringAsFixed(2)}'),
              ),
            ),
          ),
        );
      },
    );
  }
}

