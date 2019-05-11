import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:spent/models/app_state.dart';
import 'package:spent/models/expense.dart';
import 'package:spent/presentation/expenses_list.dart';
import 'package:spent/selectors/selectors.dart';

class ExpensesListContainer extends StatelessWidget {
  const ExpensesListContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      converter: _ViewModel.fromStore,
      builder: (BuildContext context, _ViewModel vm) {
        return Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildText(vm),
            Expanded(
              child: ExpensesList(
                expenses: vm.expenses,
              ),
            )
          ],
        ));
      },
    );
  }

  Widget _buildText(_ViewModel vm) => Container(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(5)),
          child: Text(
            '\$${vm.total.toString()}',
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
}

class _ViewModel {
  final List<Expense> expenses;
  final double total;
  final bool loading;

  _ViewModel(
      {@required this.expenses, @required this.total, @required this.loading});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      expenses: expensesFromState(store.state),
      total: expensesTotalFromState(store.state),
      loading: isFetchingExpenses(store.state),
    );
  }
}
