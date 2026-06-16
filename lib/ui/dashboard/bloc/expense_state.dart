import 'package:expenso_492/data/local/models/filter_expense_model.dart';

import '../../../data/local/models/expense_model.dart';

abstract class ExpenseState {}

class ExpenseInitialState extends ExpenseState{}
class ExpenseLoadingState extends ExpenseState{}
class ExpenseLoadedState extends ExpenseState{
  List<FilterExpenseModel> expenses;
  ExpenseLoadedState({required this.expenses});
}
class ExpenseFailureState extends ExpenseState{
  String errorMsg;
  ExpenseFailureState({required this.errorMsg});
}