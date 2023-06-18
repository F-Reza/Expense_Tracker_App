
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
                  Card(
                    elevation: 5,
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xFFCCCCFF),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade500,
                                offset: const Offset(4, 4),
                                blurRadius: 15,
                                spreadRadius: 1
                            ),
                            const BoxShadow(
                                color: Colors.white,
                                offset: Offset(-4, -4),
                                blurRadius: 15,
                                spreadRadius: 1
                            ),
                          ]
                      ),
                      height: 190,
                      child: const TotalChart(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Expenses',
                          style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
                        TextButton(onPressed: () {
                          Navigator.pushNamed(context, AllExpense.routeName);
                        }, child: const Text('View All',
                          style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
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


