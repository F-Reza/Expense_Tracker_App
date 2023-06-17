
import 'package:expense_tracker_app/widgets/all_expenses_screen/total_chart.dart';
import 'package:expense_tracker_app/widgets/category_screen/category_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../pages/all_expenses.dart';
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
              return Column(
                children: [
                  const Card(
                    elevation: 5,
                    color: Colors.white,
                    child: SizedBox(
                      height: 190,
                      child: TotalChart(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Expenses',
                          style: TextStyle(fontWeight: FontWeight.w500),),
                        TextButton(onPressed: () {
                          Navigator.pushNamed(context, AllExpense.routeName);
                        }, child: const Text('View All',
                          style: TextStyle(fontWeight: FontWeight.w500),),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(child: CategoryList()),
                ],
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }
    );
  }
}


