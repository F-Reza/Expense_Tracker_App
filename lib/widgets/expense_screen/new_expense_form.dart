import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../constants/icons.dart';
import '../../models/expense_model.dart';
import '../../provider/expense_provider.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key});

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _date;
  String _initialValue = 'Others';
  //String? _initialValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: titleController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Title of expense..',
                labelText: 'Title',
                prefixIcon: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Amount of expense..',
                labelText: 'Amount',
                prefixIcon: Icon(Icons.person),
              ),
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
                    Text(_date == null ?'Select Date' : _date!.toString()),
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
                          setState(() {
                            _initialValue = newValue!;
                          });
                        }),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20,),
          ElevatedButton.icon(
              onPressed: () {
                if(titleController.text != '' && amountController.text != '') {
                  if (double.tryParse(amountController.text) != null) {
                    _getData();
                  }
                }
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Expense')),
        ],
      ),
    );
  }

  void _pickDate() async{
    final selectedDate = await showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime.now()
    );

    if (selectedDate!=null) {
      setState(() {

        DateTime now = DateTime.now();
        _date = DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            now.hour,
            now.minute,
            now.second,
            now.millisecond,
            now.microsecond
        );
        //_date = selectedDate;
        //print(DateFormat.yMd().add_jm().format(selectedDate));
        //_date = DateFormat('dd/MM/yyyy').format(selectedDate);
        //_date = DateFormat('hh:mm:a').format(DateTime.now());
      });
    }
  }

  Future<void> _getData() async {
    var xDate = _date != null ? _date ! : DateTime.now();
    print('------------Insert DATA-------------');
    final expense = Expense(
      title: titleController.text,
      amount: double.parse(amountController.text),
      //date: xDate.toString(),
      date: DateTime.parse(xDate.toString()),
      category: _initialValue,
    );
    //print("---------------${expense.toString()}");
    //final rowId = await DBHelper.insertContact(contact);
    final status = await Provider
        .of<ExpenseProvider>(context, listen: false)
        .insertExpense(expense);
    if (status) {
      Navigator.pop(context);
    }
    else {
      print('------------Insert failed!-------------');
    }

  }
}
