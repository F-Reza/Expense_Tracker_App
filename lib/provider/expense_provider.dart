import 'package:flutter/foundation.dart';
import '../db/db_helper.dart';
import '../models/exp_category_model.dart';
import '../models/expense_model.dart';

class ExpenseProvider extends ChangeNotifier {

  List<ExpenseCategory> _categories = [];
  List<ExpenseCategory> get categories => _categories;

  List<Expense> _expenses = [];
  List<Expense> get expenseList => _expenses;


  getCategories() async{
    _categories = await DBHelper.getCategories();
    notifyListeners();
  }


  Future<bool> updateCategory(ExpenseCategory expenseCategory) async {

    final rowId = await DBHelper.updateCategory(expenseCategory);
    if (rowId > 0) {

      var file = _categories.firstWhere((element) => element.title == expenseCategory.title);
      file.entries = expenseCategory.entries;
      file.totalAmount = expenseCategory.totalAmount;

      notifyListeners();
      return true;
    }
    return false;
  }


  //Insert Expense
  Future<bool> insertExpense(Expense expense) async {
    final rowId = await DBHelper.insertExpense(expense);
    if(rowId > 0) {
      expense.id = rowId;
      expenseList.add(expense);
      notifyListeners();
      var ex = findCategory(expense.category);
      ex.totalAmount = ex.totalAmount + expense.amount;
      ex.entries = ex.entries + 1;
      expense.category  = ex.title;
      updateCategory(ex);
      notifyListeners();
      return true;
    }
    return false;
  }

  ExpenseCategory findCategory(String title) {
    return _categories.firstWhere((element) => element.title == title);
  }

  Map<String, dynamic> calculateEntriesAndAmount(String category) {
    double total = 0.0;
    var list = _expenses.where((element) => element.category == category);
    for (final i in list) {
      total += i.amount;
    }
    return {'entries': list.length, 'totalAmount': total};
  }

  double calculateTotalExpenses() {
    return _categories.fold(
        0.0, (previousValue, element) => previousValue + element.totalAmount);
  }


}