import 'package:flutter/material.dart';
import '../widgets/all_expenses_screen/all_expense_fetcher.dart';

class AllExpense extends StatefulWidget {
  static const String routeName = '/all_expenses';
  const AllExpense({super.key});

  @override
  State<AllExpense> createState() => _AllExpenseState();
}

class _AllExpenseState extends State<AllExpense> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Expenses'),
      ),
      body: const AllExpensesFetcher(),
    );
  }
}

