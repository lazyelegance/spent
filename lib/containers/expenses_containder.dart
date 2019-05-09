import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:spent/models/app_state.dart';
import 'package:spent/models/expense.dart';
import 'package:spent/selectors/selectors.dart';

class ExpensesListContainer extends StatelessWidget {
  const ExpensesListContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      converter: _ViewModel.fromStore,
      builder: (BuildContext context, _ViewModel vm) {
        return Container(
          child: Text(
              'expenses count: ${vm.expenses != null ? vm.expenses.length : 0}'),
        );
      },
    );
  }
}

class _ViewModel {
  final List<Expense> expenses;
  final bool loading;

  _ViewModel({@required this.expenses, @required this.loading});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      expenses: expensesFromState(store.state),
      loading: isFetchingExpenses(store.state),
    );
  }
}
