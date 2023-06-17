import 'package:expense_tracker_app/models/exp_category_model.dart';
import 'package:flutter/material.dart';
import '../widgets/expense_screen/expense_fetcher.dart';


class ExpensePage extends StatelessWidget {
  static const String routeName = '/expense';
  const ExpensePage({super.key, this.expenseCategory});
  final ExpenseCategory? expenseCategory;

  @override
  Widget build(BuildContext context) {
    var category = expenseCategory!.title;
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: ExpenseFetcher(category),
    );
  }
}
