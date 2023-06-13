import 'package:flutter/foundation.dart';

import '../db/db_helper.dart';
import '../models/exp_category_model.dart';
import '../models/expense_model.dart';



class ExpenseProvider extends ChangeNotifier {
  List<ExpenseCategory> categories = [];
  List<Expense> expenseList = [];


  getCategories() async{
    categories = await DBHelper.getCategories();
    notifyListeners();
  }


}