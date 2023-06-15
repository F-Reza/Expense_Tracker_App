import 'package:flutter/foundation.dart';
import '../db/db_helper.dart';
import '../models/exp_category_model.dart';
import '../models/expense_model.dart';

class ExpenseProvider extends ChangeNotifier {

  List<ExpenseCategory> _categories = [];
  List<ExpenseCategory> get categories => _categories;

  List<Expense> _expenses = [];
  List<Expense> get expenseList => _expenses;

  List<Expense> expensesByCat = [];

  //Get Categories
  getCategories() async{
    _categories = await DBHelper.getCategories();
    notifyListeners();
  }


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

  ExpenseCategory findCategory(String title) {
    return _categories.firstWhere((element) => element.title == title);
  }
  /*Map<String, dynamic> calculateEntriesAndAmount(String category) {
    double total = 0.0;
    var list = _expenses.where((element) => element.category == category);
    for (final i in list) {
      total += i.amount;
    }
    return {'entries': list.length, 'totalAmount': total};
  }*/

  //Calculate Total Expenses
  double calculateTotalExpenses() {
    return _categories.fold(
        0.0, (previousValue, element) => previousValue + element.totalAmount);
  }


}