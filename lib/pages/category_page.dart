
import 'package:expense_tracker_app/widgets/category_screen/category_fetcher.dart';
import 'package:flutter/material.dart';

import '../db/db_helper.dart';

class CategoryPage extends StatelessWidget {
  static const String routeName = '/';
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        actions: [
          IconButton(
              onPressed: () {
                //
              },
              icon: const Icon(Icons.save)),
        ],
      ),
      body: const CategoryFetcher(),
    );
  }
}

