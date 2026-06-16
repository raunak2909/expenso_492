import 'package:expenso_492/domain/constants/app_routes.dart';
import 'package:expenso_492/ui/dashboard/bloc/expense_bloc.dart';
import 'package:expenso_492/ui/dashboard/bloc/expense_event.dart';
import 'package:expenso_492/ui/dashboard/nav_pages/nav_home_page.dart';
import 'package:expenso_492/ui/dashboard/nav_pages/nav_stats_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  @override
  void initState() {
    super.initState();
    context.read<ExpenseBloc>().add(FetchExpenseEvent());
  }


  var mNavPages = [
    NavHomePage(),
    NavStatsPage(),
    NavHomePage(),
    NavStatsPage(),
    NavStatsPage(),
  ];


  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mNavPages[selectedIndex],
      bottomNavigationBar: Container(
        color: Colors.deepPurple.shade100,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          onTap: (value) {
            if (value == 2) {
              Navigator.pushNamed(context, AppRoutes.ADD_EXPENSE_PAGE);
            } else {
              selectedIndex = value;
              setState(() {});
            }

          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: 30, color: Colors.grey.shade400),
              label: "",
              activeIcon: Icon(
                Icons.home_filled,
                size: 30,
                  color: Colors.pink.shade200
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_outlined, size: 30, color: Colors.grey.shade400),
              label: "",
              activeIcon: Icon(
                Icons.bar_chart_rounded,
                size: 30,
                color: Colors.pink.shade200,
              ),
            ),
            BottomNavigationBarItem(
              icon: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.pink.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.add, size: 30, color: Colors.white),
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications_none_outlined,
                size: 30,
                  color: Colors.grey.shade400
              ),
              label: "",
              activeIcon: Icon(
                Icons.notifications_active,
                size: 30,
                color: Colors.pink.shade200,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle_outlined,
                size: 30,
                  color: Colors.grey.shade400
              ),
              label: "",
              activeIcon: Icon(
                Icons.account_circle_rounded,
                size: 30,
                color: Colors.pink.shade200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
