import 'package:expense_tracker_app/models/exp_category_model.dart';
import 'package:flutter/material.dart';


class ExpensePage extends StatelessWidget {
  static const String routeName = '/Expense';
  const ExpensePage({super.key, this.expenseCategory});
  final ExpenseCategory? expenseCategory;

  @override
  Widget build(BuildContext context) {
    var category = expenseCategory!.title;
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
    );
  }
}
