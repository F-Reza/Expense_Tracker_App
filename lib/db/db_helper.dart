import 'package:expense_tracker_app/models/exp_category_model.dart';
import 'package:expense_tracker_app/models/expense_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../constants/icons.dart';

class DBHelper {

  static const String createTbtExpCategory = '''
  create table $tableExpCategory(
  $expenseCatColTitle text,
  $expenseCatColEntries integer,
  $expenseCatColTotalAmount text
  )
  ''';
  static const String createTbtExpense = '''
  create table $tableExpense(
  $expenseColId integer primary key,
  $expenseColTitle text,
  $expenseColAmount text,
  $expenseColDateTime text,
  $expenseColCategory text
  )
  ''';


  Future<Database> get database async {
    return open();
  }

  //Create DataBase
  static Future<Database> open() async {
    final rootPath = await getDatabasesPath();
    final dbPath = join(rootPath, 'expense_tc.db');

    return openDatabase(dbPath, version: 1, onCreate:(db, version) {
      db.execute(createTbtExpCategory);
      db.execute(createTbtExpense);

      print('==================DB Created!====================');
      //Data insert manually
      db.transaction((txn) async {
        print('-----------------Insert Start-----------------');
        for (int i = 0; i < icons.length; i++) {
          await txn.insert(tableExpCategory, {
            expenseCatColTitle: icons.keys.toList()[i],
            expenseCatColEntries: 0,
            expenseCatColTotalAmount: (0.0).toString()
          });
        }
        print('-----------------Insert done!----------------');
      });

    });
  }



  static Future<List<ExpenseCategory>> getCategories() async {
    final db = await open();
    //final mapList = await db.query(tableExpCategory, orderBy: '$expenseCatColTitle asc');
    final mapList = await db.query(tableExpCategory);
    return List.generate(mapList.length, (index) =>
        ExpenseCategory.fromMap(mapList[index]));
  }

  //Update Category
  static Future<int> updateCategory(int entries, double totalAmount) async {
    final db = await open();
    return db.update(tableExpCategory, {
      expenseCatColEntries: entries,
      expenseCatColTotalAmount: totalAmount
    },
        where: '$expenseCatColTitle = ?',
        whereArgs: [expenseCatColTitle]);
  }

  static Future<int> insertExpense(Expense expense) async{
    final db = await open();
    return db.insert(tableExpense, expense.toMap());
  }


/*static Future<int> insertCategory(ExpenseCategory expenseCategory) async{
    final db = await open();
    return db.insert(tableExpCategory, expenseCategory.toMap());
  }*/

/*await database.transaction((txn) async {
  await txn.execute('CREATE TABLE Test1 (id INTEGER PRIMARY KEY)');
  // DON'T  use the database object in a transaction
  await database.execute('CREATE TABLE Test2 (id INTEGER PRIMARY KEY)');
  });*/

/*batch = db.batch();
  batch.insert('Test', {'name': 'item'});
  batch.update('Test', {'name': 'new_item'}, where: 'name = ?', whereArgs: ['item']);
  batch.delete('Test', where: 'name = ?', whereArgs: ['item']);
  results = await batch.commit();*/


}