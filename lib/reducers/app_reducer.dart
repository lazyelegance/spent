import 'package:spent/models/app_state.dart';
import 'package:spent/reducers/expenses_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(expensesState: expensesReducer(state.expensesState, action));
}
