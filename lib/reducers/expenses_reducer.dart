import 'package:redux/redux.dart';
import 'package:spent/actions/expenses_actions.dart';
import 'package:spent/models/expenses_state.dart';

final expensesReducer = combineReducers<ExpensesState>(
    [new TypedReducer<ExpensesState, LoadExpenses>(_setLoadExpenses)]);

ExpensesState _setLoadExpenses(
    ExpensesState expensesState, LoadExpenses action) {
  return ExpensesState(isFetching: false, expenses: action.expenses);
}
