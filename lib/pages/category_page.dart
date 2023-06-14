
import 'package:expense_tracker_app/widgets/category_screen/category_fetcher.dart';
import 'package:expense_tracker_app/widgets/expense_screen/new_expense_form.dart';
import 'package:flutter/material.dart';


class CategoryPage extends StatelessWidget {
  static const String routeName = '/';
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        centerTitle: true,
        leading: const Icon(Icons.account_balance_wallet,size: 30,),
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                    onTap: () {
                      /*setLoginStatus(false).then((value) =>
                          Navigator.pushReplacementNamed
                            (context, LoginPage.routeName));*/
                    },
                    child: const Text('Logout')
                ),
              ]
          ),
        ],
      ),
      body: const CategoryFetcher(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(context: context, builder: (_) => const ExpenseForm());
        },
        tooltip: 'Add New Expense',
        child: const Icon(Icons.add),
      ),
    );
  }
}

