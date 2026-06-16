import 'package:expenso_492/data/local/models/expense_model.dart';

abstract class ExpenseEvent {}

class AddExpenseEvent extends ExpenseEvent{
  ExpenseModel newExpense;
  AddExpenseEvent({required this.newExpense});
}
class FetchExpenseEvent extends ExpenseEvent{}