import 'package:expense_tracker_app/provider/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'all_expense_list.dart';

class AllExpensesFetcher extends StatefulWidget {
  const AllExpensesFetcher({super.key});

  @override
  State<AllExpensesFetcher> createState() => _AllExpensesFetcherState();
}

class _AllExpensesFetcherState extends State<AllExpensesFetcher> {

  late Future _allExpensesList;
  Future _getAllExpense() async {
    final provider = Provider.of<ExpenseProvider>(context, listen: false);
    return await provider.getAllExpense();
  }

  @override
  void initState() {
     _allExpensesList = _getAllExpense();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _allExpensesList,
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Center(child: Text('Failed to fetch data'));
            } else {
              return const Column(
                children: [
                  Expanded(child: AllExpensesList()),
                ],
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }
    );
  }
}

