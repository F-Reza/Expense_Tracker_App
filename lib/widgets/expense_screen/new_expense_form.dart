import 'package:flutter/material.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key});

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: titleController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Type contact name..',
                labelText: 'Name',
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if(value== null || value.isEmpty) {
                  return 'Name is required';
                }
                if(value.length>30) {
                  return 'Limit 30 character';
                }
                else {
                  return null;
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter amount..',
                labelText: 'Amount',
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if(value== null || value.isEmpty) {
                  return 'Name is required';
                }
                if(value.length>30) {
                  return 'Limit 30 character';
                }
                else {
                  return null;
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
