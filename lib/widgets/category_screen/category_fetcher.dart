
import 'package:expense_tracker_app/models/exp_category_model.dart';
import 'package:expense_tracker_app/pages/expens_page.dart';
import 'package:expense_tracker_app/widgets/all_expenses_screen/total_chart.dart';
import 'package:expense_tracker_app/widgets/category_screen/category_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/expense_provider.dart';


class CategoryFetcher extends StatefulWidget {
  const CategoryFetcher({super.key});

  @override
  State<CategoryFetcher> createState() => _CategoryFetcherState();
}

class _CategoryFetcherState extends State<CategoryFetcher> {

  late Future _categoryList;
  Future _getCategoryList() async {
    final provider = Provider.of<ExpenseProvider>(context, listen: false);
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
        future:_categoryList,
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Center(child: Text('Failed to fetch data'));
            } else {
              return const Column(
                children: [
                  Card(
                    elevation: 5,
                    color: Colors.white,
                    child: SizedBox(
                      height: 220,
                      child: TotalChart(),
                    ),
                  ),
                  Expanded(child: CategoryList()),
                ],
              );
            }
          } else {
            return const CircularProgressIndicator();
          }
        }
    );
  }
}


