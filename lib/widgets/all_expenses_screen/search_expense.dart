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
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: TextField(
        controller: searchController,
        onChanged: (value) {
          provider.searchText = value;
        },
        decoration: InputDecoration(
          fillColor: const Color(0xFF9FA8DA),
          filled: true,
          prefixIcon: const Icon(Icons.search),
          hintText: 'Search Expense...',
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () => {
              searchController.clear(),
              provider.searchText = '',
            },),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),),
        ),
      ),
    );

  }
}
