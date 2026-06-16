import 'package:expenso_492/data/local/helpers/db_helper.dart';
import 'package:expenso_492/data/local/models/cat_model.dart';
import 'package:expenso_492/data/local/models/expense_model.dart';
import 'package:expenso_492/data/local/models/filter_expense_model.dart';
import 'package:expenso_492/domain/constants/app_constants.dart';
import 'package:expenso_492/ui/dashboard/bloc/expense_event.dart';
import 'package:expenso_492/ui/dashboard/bloc/expense_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  DbHelper dbHelper;


  ExpenseBloc({required this.dbHelper}) : super(ExpenseInitialState()) {
    on<AddExpenseEvent>((event, emit) async {
      emit(ExpenseLoadingState());

      bool isAdded = await dbHelper.addExpense(newExp: event.newExpense);

      if (isAdded) {
        ///update the balance
        bool check = await dbHelper.updateBal(expType: event.newExpense.type, amt: event.newExpense.amt);
        if(check){
          /// do it yourself
        }
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
      emit(ExpenseLoadedState(expenses: filterExpense(allExp: allExpenses, filterType: event.filterType)));
    });
  }

  /// 0-> date wise
  /// 1-> month wise
  /// 2-> year wise
  /// 3-> category wise
  List<FilterExpenseModel> filterExpense({required List<ExpenseModel> allExp, int filterType = 0}) {
    List<FilterExpenseModel> mFilteredExp = [];

    if(filterType<3){
      ///date, month, year wise

      /// date format
      DateFormat df = DateFormat.yMMMMEEEEd();

      if(filterType==1){
        /// month format
        df = DateFormat.yMMMM();
      } else if(filterType==2){
        /// year format
        df = DateFormat.y();
      }

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
    } else {
      /// cat wise

      for(CatModel eachCat in AppConstants.mCategories){
        num eachCatAmt = 0;
        List<ExpenseModel> eachCatExp = [];

        for (ExpenseModel eachExp in allExp) {
          int catId = eachExp.cat_id;

          if (eachCat.id == catId) {
            eachCatExp.add(eachExp);

            if (eachExp.type == 0) {
              eachCatAmt -= eachExp.amt;

              ///debit
            } else {
              eachCatAmt += eachExp.amt;

              ///credit
            }
          }
        }

        if(eachCatExp.isNotEmpty){
          mFilteredExp.add(FilterExpenseModel(
              title: eachCat.name,
              totalAmt: eachCatAmt,
              expenses: eachCatExp));
        }
      }

    }

    return mFilteredExp;
  }
}
