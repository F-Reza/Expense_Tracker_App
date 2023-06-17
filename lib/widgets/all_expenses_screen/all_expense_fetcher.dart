import 'package:expense_tracker_app/provider/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              final provider = Provider.of<ExpenseProvider>(context, listen: false);
              var expList = provider.expenseList;
              return Column(
                children: [
                  expList.isEmpty? const SizedBox():
                  Card(
                    elevation: 5,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('data'),
                    ),
                  ),
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