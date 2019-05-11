import 'package:spent/models/app_state.dart';
import 'package:spent/models/expense.dart';

List<Expense> expensesFromState(AppState state) => state.expensesState.expenses;
double expensesTotalFromState(AppState state) {
  List<Expense> expenses = state.expensesState.expenses;

  if (expenses == null) {
    return 0;
  }

  List<double> amounts = expenses
      .map((expense) => double.tryParse(expense.amount) ?? 0.0)
      .toList();

  double total = amounts.reduce((amount, element) => amount + element);

  return total;
}

bool isFetchingExpenses(AppState state) => state.expensesState.isFetching;
