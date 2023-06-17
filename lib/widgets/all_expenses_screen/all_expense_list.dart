import 'package:expense_tracker_app/constants/icons.dart';
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
        return expList.isEmpty ?
        const Center(child: Text('isEmpty!')):
        ListView.builder(
          itemCount: expList.length,
          itemBuilder: (context, i) => Card(
            elevation: 3,
            child: ListTile(
              leading: Icon(icons[expList[i].category],size: 30,),
              title: Text(expList[i].title),
              subtitle: Text(DateFormat('dd, MMM, yyyy, hh:mm:a').format(expList[i].date)),
              //subtitle: Text(exList[i].date.toString()),
              trailing: Text('৳ ${expList[i].amount.toStringAsFixed(2)}'),
            ),
          ),
        );
      },
    );
  }
}
