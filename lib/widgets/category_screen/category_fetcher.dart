
import 'package:expense_tracker_app/pages/expens_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/expense_provider.dart';


class CategoryFetcher extends StatefulWidget {
  const CategoryFetcher({super.key});

  @override
  State<CategoryFetcher> createState() => _CategoryFetcherState();
}

class _CategoryFetcherState extends State<CategoryFetcher> {

  Future _getCategoryList() async {
    final provider = Provider.of<ExpenseProvider>(context, listen: false);
    return await provider.getCategories();
  }
  
  @override
  void initState() {
    _getCategoryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(
      builder: (context, provider, _) => ListView.builder(
          itemCount: provider.categories.length,
          itemBuilder: (context, index) {
            final model = provider.categories[index];
            //print('-------$contact');
            return Card(
              elevation: 5,
              color: Colors.white70,
              child: ListTile(
                onTap: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>
                        ExpensePage(expenseCategory: model)),
                  );
                },
                leading: Icon(model.icon,size: 35,color: Colors.blue,),
                title: Text(model.title,style: const TextStyle(fontSize: 16,color: Colors.blue)),
                subtitle: Text('entries: ${model.entries}'),
                trailing: Text('৳ ${model.totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 16,color: Colors.blue)),
              ),
            );
          }),
    );
  }
}

