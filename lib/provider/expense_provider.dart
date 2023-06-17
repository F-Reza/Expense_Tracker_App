
import 'package:flutter/foundation.dart';
import '../db/db_helper.dart';
import '../models/exp_category_model.dart';
import '../models/expense_model.dart';

class ExpenseProvider extends ChangeNotifier {

  List<ExpenseCategory> _categories = [];
  List<ExpenseCategory> get categories => _categories;

  List<Expense> _expenses = [];
  List<Expense> get expenseList {
    return _searchText != ''?
    _expenses.where((e) =>
    e.title.toLowerCase().contains(_searchText.toLowerCase()) ).toList()
        : _expenses;
  }


  //Search Expense
  String _searchText = '';
  String get searchText => _searchText;
  set searchText(String value) {
    _searchText = value;
    notifyListeners();
  }

  //Get Categories
  getCategories() async{
    _categories = await DBHelper.getCategories();
    notifyListeners();
  }

  //Get Expense
  getExpense(String title) async{
    _expenses = await DBHelper.getExpensesByTitle(title);
    notifyListeners();
  }

  //Update Category
  Future<void> updateCategory(String category, int entries, double totalAmount) async {
    var file = _categories.firstWhere((element) => element.title == category);
    file.entries = entries;
    file.totalAmount = totalAmount;
    await DBHelper.updateCategory(category, entries, totalAmount);
    notifyListeners();
  }

  //Insert Expense
  Future<bool> insertExpense(Expense expense) async {
    final rowId = await DBHelper.insertExpense(expense);
    if(rowId > 0) {
      expense.id = rowId;
      _expenses.add(expense);
      notifyListeners();
      var ex = findCategory(expense.category);
      updateCategory(
          expense.category,
          ex.entries + 1,
          ex.totalAmount + expense.amount
      );
      notifyListeners();
      return true;
    }
    return false;
  }

  getAllExpense() async{
    _expenses = await DBHelper.getAllExpense();
    notifyListeners();
  }


  //Delete Expense
  deleteExpense(Expense expense) async {
    await DBHelper.deleteExpense(expense);
      _expenses.removeWhere((element) => element.id == expense.id);
      notifyListeners();

      var ex = findCategory(expense.category);
      updateCategory(
          expense.category,
          ex.entries - 1,
          ex.totalAmount - expense.amount
      );
  }

  Future<void> deleteExpense1(int expId, String category, double amount) async {
    await DBHelper.deleteExpense1(expId, category, amount);
    _expenses.removeWhere((element) => element.id == expId);
    notifyListeners();
    var ex = findCategory(category);
    updateCategory(
        category,
        ex.entries - 1,
        ex.totalAmount - amount
    );
    notifyListeners();
  }



  ExpenseCategory findCategory(String title) {
    return _categories.firstWhere((element) => element.title == title);
  }

  //Calculate Entries And Amount
  Map<String, dynamic> calculateEntriesAndAmount(String category) {
    double total = 0.0;
    var list = _expenses.where((element) => element.category == category);
    for (final i in list) {
      total += i.amount;
    }
    return {'entries': list.length, 'totalAmount': total};
  }

  //Calculate Total Expenses
  double calculateTotalExpenses() {
    return _categories.fold(
        0.0, (previousValue, element) => previousValue + element.totalAmount);
  }

  //Calculate Week Expenses
  List<Map<String, dynamic>> calculateWeekExpenses() {
    List<Map<String, dynamic>> data = [];

    for (int i = 0; i < 7; i++) {
      double total = 0.0;
      final weekDay = DateTime.now().subtract(Duration(days: i));

      for (int j = 0; j < _expenses.length; j++) {
        if (_expenses[j].date.year == weekDay.year &&
            _expenses[j].date.month == weekDay.month &&
            _expenses[j].date.day == weekDay.day)
        {
          total += _expenses[j].amount;
        }
      }

      data.add({'day': weekDay, 'amount': total});
    }
    return data;
  }




}