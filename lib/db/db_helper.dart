import 'package:expense_tracker_app/models/exp_category_model.dart';
import 'package:expense_tracker_app/models/expense_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../constants/icons.dart';

class DBHelper {

  static const String createTbtExpCategory = '''
  create table $tableExpCategory(
  $expenseColTitle text,
  $expenseCatColEntries integer,
  $expenseCatColTotalAmount text,
  )
  ''';
  static const String createTbtExpense = '''
  create table $tableExpense(
  $expenseColId integer primary key autoincrement,
  $expenseColTitle text,
  $expenseColAmount text,
  $expenseColDateTime text,
  $expenseColCategory text
  )
  ''';

  //Create DataBase
  static Future<Database> open() async {
    final rootPath = await getDatabasesPath();
    final dbPath = join(rootPath, 'expense_tc.db');

    return openDatabase(dbPath, version: 1, onCreate:(db, version) {
      db.execute(createTbtExpCategory);
      db.execute(createTbtExpense);


      db.transaction((txn) async {
        for (int i = 0; i < icons.length; i++) {
          await txn.insert(createTbtExpCategory, {
            expenseCatColTitle: icons.keys.toList()[i],
            expenseCatColEntries: 0,
            expenseCatColTotalAmount: (0.0).toString(),
          });
        }
      });


    });
  }



}