import 'package:spent/models/expenses_state.dart';

class AppState {
  final ExpensesState expensesState;

  AppState({this.expensesState});

  AppState copyWith({bool isLoading}) {
    return AppState(expensesState: expensesState ?? this.expensesState);
  }

  factory AppState.loading() =>
      AppState(expensesState: ExpensesState(isFetching: false, expenses: null));
}
