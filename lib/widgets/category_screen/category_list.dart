import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/colors.dart';
import '../../pages/expens_page.dart';
import '../../provider/expense_provider.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(
      builder: (context, provider, _) {
        var catList = provider.categories;
        return catList.isEmpty ?
        const Center(child: Text('isEmpty!')):
        ListView.builder(
          itemCount: catList.length,
          itemBuilder: (context, i)  {
            final model = catList[i];
            return Card(
              elevation: 5,
              //color: colors[i],
              child: ListTile(
                onTap: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>
                        ExpensePage(expenseCategory: model)),
                  );
                },
                leading: Icon(model.icon,size: 30,color: Colors.blue,),
                title: Text(model.title,style: const TextStyle(fontSize: 16,color: Colors.blue)),
                subtitle: Text('entries: ${model.entries}'),
                trailing: Text('৳ ${model.totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 16,)),
              ),
            );
          }

        );
      },
    );
  }
}
