import 'dart:math';

import 'package:expenso_492/data/local/models/filter_expense_model.dart';
import 'package:expenso_492/ui/dashboard/bloc/expense_bloc.dart';
import 'package:expenso_492/ui/dashboard/bloc/expense_state.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/expense_event.dart';

class NavStatsPage extends StatelessWidget {
  List<String> mFilterType = [
    "Date-wise",
    "Month-wise",
    "Year-wise",
    "Category-wise",
  ];
  int selectedFilterTypeIndex = 0;
  /*List<FilterExpenseModel> mDummyData = [
    FilterExpenseModel(title: "Jan", expenses: [], totalAmt: 50000),
    FilterExpenseModel(title: "Feb", expenses: [], totalAmt: 40000),
    FilterExpenseModel(title: "Mar", expenses: [], totalAmt: 80000),
    FilterExpenseModel(title: "Apr", expenses: [], totalAmt: 20000),
    FilterExpenseModel(title: "May", expenses: [], totalAmt: 76000),
  ];*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /*Container(
                padding: EdgeInsets.all(11),
                height: 150,
                color: Colors.blueAccent.shade100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        width: double.infinity,
                        color: Colors.blueAccent.shade100,
                        height: 7,
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 7,
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(11)
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: 7,
                              decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(11)
                              ),
                            )
                          ],
                        )),
                  ],
                ),
              ),*/

              BlocBuilder<ExpenseBloc, ExpenseState>(
                builder: (context, state) {

                  if(state is ExpenseLoadedState){
                    var mData = state.expenses;
                    selectedFilterTypeIndex =
                        state.filterType;
                    print("filter index in stats : $selectedFilterTypeIndex");
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 180,
                              child: DropdownMenu(
                                onSelected: (index) {
                                  selectedFilterTypeIndex = index!;
                                  context.read<ExpenseBloc>().add(
                                    FetchExpenseEvent(
                                      filterType: selectedFilterTypeIndex,
                                    ),
                                  );
                                },
                                initialSelection: selectedFilterTypeIndex,
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
                            )
                          ],
                        ),
                        SizedBox(
                          height: 11,
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 25, bottom: 11),
                          width: double.infinity,
                          height: 280,
                          color: Colors.pink.shade100,
                          child: BarChart(
                            BarChartData(
                              maxY: 100000,
                              titlesData: FlTitlesData(
                                  show: true,
                                  bottomTitles: AxisTitles(
                                      axisNameWidget: Text("Months"),
                                      sideTitles: SideTitles(
                                          showTitles: true,
                                          getTitlesWidget: (index, _){
                                            return Text(mData[index.toInt()].title);
                                          }
                                      )
                                  )
                              ),
                              barGroups: List.generate(mData.length, (index) {
                                return BarChartGroupData(
                                  x: index,
                                  barRods: [
                                    BarChartRodData(
                                      toY: mData[index].totalAmt.abs().toDouble(),
                                      color: Colors.white,
                                      width: 30,
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(5),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ),
                          ),
                        ),
                      ],
                    );
                  }


                  return Container();
                }
              ),
              /*Container(
                padding: EdgeInsets.only(top: 25, bottom: 11),
                width: double.infinity,
                height: 280,
                color: Colors.pink.shade100,
                child: PieChart(
                  PieChartData(
                    sections: List.generate(mDummyData.length, (index) {
                      return PieChartSectionData(
                        value: mDummyData[index].totalAmt.toDouble(),
                        color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                        title: mDummyData[index].title,
                      );
                    }),
                  )
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
