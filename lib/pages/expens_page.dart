import 'package:flutter/material.dart';

class ExpensePage extends StatelessWidget {
  static const String routeName = '/Expense';
  const ExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Page'),
      ),
    );
  }
}
