import 'package:flutter/material.dart';
class CategoryPage extends StatelessWidget {
  static const String routeName = '/';
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
    );
  }
}
