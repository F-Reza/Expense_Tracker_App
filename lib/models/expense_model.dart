
const String tableExpense = 'tbl_Expense';
const String expenseColId = 'id';
const String expenseColTitle = 'title';
const String expenseColAmount = 'amount';
const String expenseColDateTime = 'date';
const String expenseColCategory = 'category';



class Expense{
  int? id;
  String title;
  double amount;
  DateTime date;
  String category;

  Expense({
    this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category});

  Map <String, dynamic> toMap() {
    var map = <String,dynamic> {
      expenseColTitle: title,
      expenseColAmount: amount.toString(),
      expenseColDateTime: date.toString(),
      expenseColCategory: category,
    };
    if(id != null){
      map[expenseColId] = id;
    }
    return map;
  }

  factory Expense.fromMap(Map<String, dynamic> map) => Expense(
      id: map[expenseColId],
      title: map[expenseColTitle],
      amount: double.parse(map[expenseColAmount]),
      date: DateTime.parse(map[expenseColDateTime]),
      category: map[expenseColCategory],);

  @override
  String toString() {
    return 'Expense{id: $id, title: $title, amount: $amount, date: $date, category: $category}';
  }
}