import 'expense_model.dart';

class FilterExpenseModel{

  String title; ///date
  num totalAmt;
  List<ExpenseModel> expenses;

  FilterExpenseModel({
    required this.title,
    required this.totalAmt,
    required this.expenses,
  });

}