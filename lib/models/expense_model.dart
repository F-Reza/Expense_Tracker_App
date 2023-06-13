
const String tableExpense = 'tbl_Expense';
const String expenseColId = 'id';
const String expenseColTitle = 'title';
const String expenseColAmount = 'amount';
const String expenseColDateTime = 'dateTime';
const String expenseColCategory = 'category';



class Expense{
  final int id;
  final String title;
  final double amount;
  final DateTime dateTime;
  final String category;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.dateTime,
    required this.category});

  Map <String, dynamic> toMap() {
    var map = <String,dynamic> {
      expenseColId: id,
      expenseColTitle: title,
      expenseColAmount: amount,
      expenseColDateTime: dateTime,
      expenseColCategory: category,
    };
    return map;
  }

  factory Expense.fromMap(Map<String, dynamic> map) => Expense(
      id: map[expenseColId],
      title: map[expenseColTitle],
      amount: map[expenseColAmount],
      dateTime: map[expenseColDateTime],
      category: map[expenseColCategory],);

  @override
  String toString() {
    return 'Expense{id: $id, title: $title, amount: $amount, dateTime: $dateTime, category: $category}';
  }
}