import 'package:spent/models/expense.dart';

class ExpensesState {
  final bool isFetching;
  final List<Expense> expenses;

  ExpensesState({this.isFetching, this.expenses});

  factory ExpensesState.fetching() => ExpensesState(isFetching: true);
}
