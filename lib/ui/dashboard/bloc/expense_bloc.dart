import 'package:expenso_492/data/local/helpers/db_helper.dart';
import 'package:expenso_492/data/local/models/expense_model.dart';
import 'package:expenso_492/data/local/models/filter_expense_model.dart';
import 'package:expenso_492/ui/dashboard/bloc/expense_event.dart';
import 'package:expenso_492/ui/dashboard/bloc/expense_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  DbHelper dbHelper;
  DateFormat df = DateFormat.yMMMEd();

  ExpenseBloc({required this.dbHelper}) : super(ExpenseInitialState()) {
    on<AddExpenseEvent>((event, emit) async {
      emit(ExpenseLoadingState());

      bool isAdded = await dbHelper.addExpense(newExp: event.newExpense);

      if (isAdded) {
        List<ExpenseModel> allExpenses = await dbHelper.fetchAllExp();
        emit(ExpenseLoadedState(expenses: filterExpense(allExp: allExpenses)));
      } else {
        emit(ExpenseFailureState(errorMsg: "Something went wrong!!"));
      }
    });

    ///
    on<FetchExpenseEvent>((event, emit) async {
      emit(ExpenseLoadingState());
      List<ExpenseModel> allExpenses = await dbHelper.fetchAllExp();
      emit(ExpenseLoadedState(expenses: filterExpense(allExp: allExpenses)));
    });
  }

  List<FilterExpenseModel> filterExpense({required List<ExpenseModel> allExp}) {
    List<FilterExpenseModel> mFilteredExp = [];

    ///step 1 get all the unique dates
    List<String> uniqueDates = [];

    for (ExpenseModel eachExp in allExp) {
      String expDate = df.format(
        DateTime.fromMillisecondsSinceEpoch(eachExp.created_at),
      );

      if (!uniqueDates.contains(expDate)) {
        uniqueDates.add(expDate);
      }
    }

    for (String eachDate in uniqueDates) {
      num eachDateAmt = 0;
      List<ExpenseModel> eachDateExp = [];

      for (ExpenseModel eachExp in allExp) {
        String expDate = df.format(
          DateTime.fromMillisecondsSinceEpoch(eachExp.created_at),
        );

        if (eachDate == expDate) {
          eachDateExp.add(eachExp);

          if (eachExp.type == 0) {
            eachDateAmt -= eachExp.amt;

            ///debit
          } else {
            eachDateAmt += eachExp.amt;

            ///credit
          }
        }
      }

      mFilteredExp.add(
        FilterExpenseModel(
          title: eachDate,
          totalAmt: eachDateAmt,
          expenses: eachDateExp,
        ),
      );
    }

    return mFilteredExp;
  }
}
