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

  /*Future _getCategoryList() async {
    final provider = Provider.of<ExpenseProvider>(context, listen: false);
    return await provider.getCategories();
  }

  @override
  void initState() {
    _getCategoryList();
    super.initState();
  }
*/
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ExpenseProvider>(context, listen: false);
    return Consumer<ExpenseProvider>(
      builder: (context, provider, _) => FutureBuilder<Expense>(
      future: provider.getExpensesByTitle('Transport'),
      builder: (context, snapshot){
        if(snapshot.hasData) {
          final model = snapshot.data;
          return ListView(
            children: const [
              Text('fetch data'),
            ],
          );
        }
        if(snapshot.hasError){
          return const Center(child: Text('Failed to fetch data'));
        }
        return const CircularProgressIndicator();
      },
    ),
    );
    /*ListView.builder(
        itemCount: provider.expenseList.length,
        itemBuilder: (context, index) {
          final contact = provider.expenseList[index];
          return Text(contact.title);
        });*/
  }
}
