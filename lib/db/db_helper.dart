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
    print('------------------ Started ------------------');
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


  static Future<int> insertCategory(ExpenseCategory expenseCategory) async{
    final db = await open();
    return db.insert(tableExpCategory, expenseCategory.toMap());
  }

  static Future<List<ExpenseCategory>> getCategories() async {
    final db = await open();
    final mapList = await db.query(tableExpCategory, orderBy: '$expenseCatColTitle asc');
    return List.generate(mapList.length, (index) =>
        ExpenseCategory.fromMap(mapList[index]));
  }

  /*static Future<List<ExpenseCategory>> fetchCategories() async {
    final db = await open();
    return await db.transaction((txn) async {
      return await txn.query(tableExpCategory).then((data) {
        final converted = List<Map<String, dynamic>>.from(data);
        List<ExpenseCategory> nList = List.generate(converted.length,
                (index) => ExpenseCategory.fromMap(converted[index]));
        return nList;
      });
    });
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