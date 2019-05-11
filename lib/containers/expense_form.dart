import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:spent/actions/expenses_actions.dart';
import 'package:spent/models/app_state.dart';
import 'package:spent/navigation/navigation.dart';

enum Category { Food, Entertainment, Rent, Travel }

class ExpenseForm extends StatefulWidget {
  ExpenseForm({Key key}) : super(key: key);

  _ExpenseFormState createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  String _name = '';
  String _amount = '0';
  String _category = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      converter: _ViewModel.fromStore,
      builder: (BuildContext context, _ViewModel vm) {
        return Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                  onSaved: (String value) {
                    this._name = value;
                  },
                  cursorColor: Colors.black,
                ),
                TextFormField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Amount',
                  ),
                  cursorColor: Colors.black,
                  onSaved: (String value) {
                    this._amount = value;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Category',
                  ),
                  onSaved: (String value) {
                    this._category = value;
                  },
                  cursorColor: Colors.black,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                ),
                RaisedButton(
                  onPressed: () {
                    _formKey.currentState.save();
                    // FIXME: disable button before
                    if (_name != null && _name != '' && _category != '') {
                      vm.addExpenseAction(_name, _amount, _category,
                          LocalNavigator(Navigator.of(context)));
                    }
                  },
                  child: Text('Add'),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ViewModel {
  final Function addExpenseAction;

  _ViewModel({this.addExpenseAction});

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
      addExpenseAction: (String name, String amount, String category,
          LocalNavigator navigator) {
        store.dispatch(AddExpense(
            name: name,
            amount: amount,
            category: category,
            navigator: navigator));
      },
    );
  }
}
