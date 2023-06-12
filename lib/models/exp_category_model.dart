
import 'package:flutter/material.dart';

import '../constants/icons.dart';

const String tableExpCategory= 'tbl_exp_Category';
const String expenseCatColTitle = 'title';
const String expenseCatColEntries = 'entries';
const String expenseCatColTotalAmount = 'totalAmount';

class ExpenseCategory{
  final String title;
  int entries = 0;
  double totalAmount = 0.0;
  final IconData icon;

  ExpenseCategory({
    required this.title,
    required this.entries,
    required this.totalAmount,
    required this.icon});

  Map <String, dynamic> toMap() {
    var map = <String,dynamic> {
    expenseCatColTitle: title,
    expenseCatColEntries: entries,
    expenseCatColTotalAmount: totalAmount,
    };
    return map;
  }

  factory ExpenseCategory.fromMap(Map<String, dynamic> map) => ExpenseCategory(
      title: map[expenseCatColTitle],
      entries: map[expenseCatColEntries],
      totalAmount: map[expenseCatColTotalAmount],
      icon: icons[map[expenseCatColTitle]]!);

  @override
  String toString() {
    return 'ExpenseCategory{title: $title, entries: $entries, totalAmount: $totalAmount, icon: $icon}';
  }
}