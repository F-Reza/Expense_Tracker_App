import 'package:expense_tracker_app/pages/category_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/expens_page.dart';
import 'provider/expense_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ExpenseProvider()),
    ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker App',
      theme: ThemeData(
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      initialRoute: CategoryPage.routeName,
      routes: {
        CategoryPage.routeName: (context) => const CategoryPage(),
        ExpensePage.routeName: (context) => const ExpensePage(),
      },

    );
  }
}


