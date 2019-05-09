import 'package:spent/models/app_state.dart';
import 'package:spent/models/expense.dart';

List<Expense> expensesFromState(AppState state) => state.expensesState.expenses;
bool isFetchingExpenses(AppState state) => state.expensesState.isFetching;
