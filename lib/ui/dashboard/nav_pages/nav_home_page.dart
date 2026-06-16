import 'package:expenso_492/data/local/models/expense_model.dart';
import 'package:expenso_492/data/local/models/filter_expense_model.dart';
import 'package:expenso_492/ui/dashboard/bloc/expense_bloc.dart';
import 'package:expenso_492/ui/dashboard/bloc/expense_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavHomePage extends StatelessWidget {
  const NavHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
      body: BlocBuilder<ExpenseBloc, ExpenseState>(
        builder: (_, state) {
          if (state is ExpenseLoadingState) {
            return Center(
              child: CircularProgressIndicator(color: Colors.pink.shade200),
            );
          }

          if (state is ExpenseLoadedState) {
            List<FilterExpenseModel> allExp = state.expenses;

            ///ListView.builder(
            //               itemCount: allExp.length,
            //                 itemBuilder: (_, index){
            //                   ExpenseModel eachExp = allExp[index];
            //
            //                   return ListTile(
            //                     title: Text(eachExp.title),
            //                     subtitle: Text(eachExp.remark),
            //                     trailing: Text("₹${eachExp.amt}"),
            //                   );
            //
            //             })


            return allExp.isNotEmpty
                ? ListView.builder(itemBuilder: (_, index){
                  return Container(

                  );
            })
                : Center(child: Text('No Expenses yet!!'));
          }

          if (state is ExpenseFailureState) {
            return Center(child: Text(state.errorMsg));
          }

          return Container();
        },
      ),
    );
  }
}
