import 'dart:math';

import 'package:expenso_492/data/local/models/filter_expense_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class NavStatsPage extends StatelessWidget {
  List<FilterExpenseModel> mDummyData = [
    FilterExpenseModel(title: "Jan", expenses: [], totalAmt: 50000),
    FilterExpenseModel(title: "Feb", expenses: [], totalAmt: 40000),
    FilterExpenseModel(title: "Mar", expenses: [], totalAmt: 80000),
    FilterExpenseModel(title: "Apr", expenses: [], totalAmt: 20000),
    FilterExpenseModel(title: "May", expenses: [], totalAmt: 76000),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
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
                          return Text(mDummyData[index.toInt()].title);
                        }
                      )
                    )
                  ),
                  barGroups: List.generate(mDummyData.length, (index) {
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: mDummyData[index].totalAmt.toDouble(),
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
            Container(
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
            ),
          ],
        ),
      ),
    );
  }
}
