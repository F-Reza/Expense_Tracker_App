import 'package:expense_tracker_app/provider/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchExpense extends StatefulWidget {
  const SearchExpense({super.key});

  @override
  State<SearchExpense> createState() => _SearchExpenseState();
}

class _SearchExpenseState extends State<SearchExpense> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ExpenseProvider>(context, listen: false);
    return TextField(
      controller: searchController,
      onChanged: (value) {
        provider.searchText = value;
      },
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: 'Search Expense...',
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => {
            searchController.clear(),
            provider.searchText = '',
          },),
        border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(0.0),),
      ),
    );

  }
}
