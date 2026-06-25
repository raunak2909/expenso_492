import 'dart:math';

import 'package:expenso_492/data/local/models/cat_model.dart';
import 'package:expenso_492/data/local/models/expense_model.dart';
import 'package:expenso_492/data/local/models/filter_expense_model.dart';
import 'package:expenso_492/domain/constants/app_constants.dart';
import 'package:expenso_492/domain/constants/app_routes.dart';
import 'package:expenso_492/ui/dashboard/bloc/expense_bloc.dart';
import 'package:expenso_492/ui/dashboard/bloc/expense_event.dart';
import 'package:expenso_492/ui/dashboard/bloc/expense_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavHomePage extends StatelessWidget {
  List<String> mFilterType = [
    "Date-wise",
    "Month-wise",
    "Year-wise",
    "Category-wise",
  ];
  int selectedFilterTypeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 100),
          IconButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();

              ///prefs.setInt(AppConstants.PREF_USER_ID, 0);
              prefs.clear();
              Navigator.pushReplacementNamed(context, AppRoutes.LOGIN_PAGE);
            },
            icon: Icon(Icons.logout),
          ),
          Expanded(
            child: BlocBuilder<ExpenseBloc, ExpenseState>(
              builder: (_, state) {
                if (state is ExpenseLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.pink.shade200,
                    ),
                  );
                }

                if (state is ExpenseLoadedState) {
                  var allExp = state.expenses;
                  selectedFilterTypeIndex =
                      state.filterType;
                  print("filter index in home : $selectedFilterTypeIndex");
                  return allExp.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(11.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Expense List",
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 180,
                                    child: DropdownMenu(
                                        onSelected: (index) {
                                          selectedFilterTypeIndex = index!;
                                          context.read<ExpenseBloc>().add(
                                            FetchExpenseEvent(
                                              filterType:
                                                  selectedFilterTypeIndex,
                                            ),
                                          );
                                        },
                                        initialSelection:
                                            selectedFilterTypeIndex,
                                        dropdownMenuEntries: List.generate(
                                          mFilterType.length,
                                          (index) {
                                            return DropdownMenuEntry(
                                              value: index,
                                              label: mFilterType[index],
                                            );
                                          },
                                        ),
                                        width: double.infinity,
                                        label: Text("Type"),
                                        inputDecorationTheme:
                                            InputDecorationTheme(
                                              filled: true,
                                              fillColor: Colors.white,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(21),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(21),
                                                borderSide: BorderSide(
                                                  color: Colors.pink.shade200,
                                                  width: 2,
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(21),
                                              ),
                                            ),
                                      ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 11),
                              Expanded(
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: allExp.length,
                                  itemBuilder: (_, index) {
                                    return Container(
                                      padding: EdgeInsets.all(11),
                                      margin: EdgeInsets.only(bottom: 11),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(11),
                                        border: Border.all(
                                          color: Colors.black12,
                                          width: 2,
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                allExp[index].title,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "₹ ${allExp[index].totalAmt}",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 7),
                                          Divider(
                                            color: Colors.black12,
                                            thickness: 2,
                                          ),
                                          SizedBox(height: 7),
                                          ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount:
                                                allExp[index].expenses.length,
                                            itemBuilder: (_, childIndex) {
                                              ExpenseModel eachExp =
                                                  allExp[index]
                                                      .expenses[childIndex];

                                              CatModel currCatModel =
                                                  AppConstants.mCategories
                                                      .firstWhere((eachCat) {
                                                        return eachCat.id ==
                                                            eachExp.cat_id;
                                                      });

                                              return ListTile(
                                                leading: Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          5,
                                                        ),
                                                    color: Colors
                                                        .primaries[Random()
                                                            .nextInt(
                                                              Colors
                                                                  .primaries
                                                                  .length,
                                                            )]
                                                        .shade100,
                                                  ),
                                                  child: Center(
                                                    child: Image.asset(
                                                      currCatModel.imgPath,
                                                      width: 30,
                                                      height: 30,
                                                    ),
                                                  ),
                                                ),
                                                title: Text(eachExp.title),
                                                subtitle: Text(eachExp.remark),
                                                trailing: Text(
                                                  "₹${eachExp.amt}",
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      : Center(child: Text('No Expenses yet!!'));
                }

                if (state is ExpenseFailureState) {
                  return Center(child: Text(state.errorMsg));
                }

                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
