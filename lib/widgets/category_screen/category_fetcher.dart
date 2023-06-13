import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import '../../provider/expense_providet.dart';

class CategoryFetcher extends StatefulWidget {
  const CategoryFetcher({super.key});

  @override
  State<CategoryFetcher> createState() => _CategoryFetcherState();
}

class _CategoryFetcherState extends State<CategoryFetcher> {

  late Future _categoryList;
  Future _getCategoryList() async {
    final provider = Provider.of<ExpenseProvider>(context as BuildContext, listen: false);
    return await provider.getCategories();
  }

  @override
  void initState() {
    _categoryList = _getCategoryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _categoryList,
        builder: (context, snapshot) {
        if(snapshot.hasData) {
          final model = snapshot.data;
          return Consumer<ExpenseProvider>(
            builder: (context, provider, _) {
              final list = provider.categories;
              return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (_, index) => ListTile(
                    title: Text(list[index].title),
                  subtitle: Text(list[index].totalAmount.toString()),
                ),
              );
            }
          );
        }
        if(snapshot.hasError){
          return const Center(child: Text('Failed to fetch data'));
        }
        return const CircularProgressIndicator();
        }
    );
  }
}
