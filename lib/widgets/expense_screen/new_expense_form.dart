import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants/icons.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key});

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  String? _date;
  String _initialValue = 'Others';

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
                hintText: 'Title of expense..',
                labelText: 'Title',
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
                hintText: 'Amount of expense..',
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_date==null ?'Select Date' : _date!),
                    IconButton(
                        onPressed: () => _pickDate(),
                        icon: const Icon(Icons.calendar_month)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    const Expanded(child: Text('Select Category')),
                    DropdownButton(
                        items: icons.keys.map((e) => DropdownMenuItem(
                            value: e,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(e),
                            ),
                        ),
                        ).toList(),
                        value: _initialValue,
                        onChanged: (newValue){
                          _initialValue = newValue!;
                        }),
                  ],
                ),
              ),
            ),
          ),
         /* DropdownButton<String>(
            isExpanded: true,
            value: _initialValue,
            hint: const Text('Select Your Blood Group'),
            items: icons.keys.map((e) =>
                DropdownMenuItem(
                    value: e,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(e),
                    )),
            ).toList(),
            onChanged: (value) {
              setState(() {
                _initialValue = value!;
              });
            },
          ),*/
          
        ],
      ),
    );
  }

  void _pickDate() async{
    final selectedDate = await showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime.now());

    if (selectedDate!=null) {
      setState(() {
        _date = DateFormat('dd/MM/yyyy').format(selectedDate);
        //_date = DateFormat('hh:mm:a').format(DateTime.now());
      });
    }
  }
}
