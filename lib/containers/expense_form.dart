import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:spent/actions/expenses_actions.dart';
import 'package:spent/models/app_state.dart';
import 'package:spent/models/category.dart';
import 'package:spent/navigation/navigation.dart';
import 'package:spent/utils/date_time.dart';

//TODO: Move this
List<Category> defaultCategories = [
  Category(name: 'Food', icon: '🍕'),
  Category(name: 'Groceries', icon: '🛒'),
  Category(name: 'Rent', icon: '🏠'),
  Category(name: 'Travel', icon: '🚌'),
  Category(name: 'Entertainment', icon: '🎫'),
  Category(name: 'Other', icon: '🎱'),
  Category(name: 'Add', icon: '➕')
];

class ExpenseForm extends StatefulWidget {
  ExpenseForm({Key key}) : super(key: key);

  _ExpenseFormState createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  String _name = '';
  String _amount = '0';
  String _category = defaultCategories[0].name;
  DateTime selectedDate = DateTime.now();
  bool showCategoryFields = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2018, 8),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

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
                    labelText: 'Detail',
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
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                ),
                RaisedButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Expense Date: ${formatDate(selectedDate)}'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                ),
                DropdownButton(
                  value: _category,
                  onChanged: (String newValue) {
                    if (newValue == 'Add') {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text('add a new Category'),
                              content: TextField(
                                decoration: new InputDecoration(
                                    labelText: "Category Name"),
                                onChanged: (String text) {
                                  //
                                },
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('Cancel'.toUpperCase()),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                FlatButton(
                                  child: Text('Add'.toUpperCase()),
                                  onPressed: () {
                                    // add
                                  },
                                ),
                              ],
                            ),
                      );
                    } else {
                      setState(() {
                        _category = newValue;
                        showCategoryFields = false;
                      });
                    }
                  },
                  items: defaultCategories.map((category) {
                    return DropdownMenuItem(
                      value: category.name,
                      child: Row(
                        children: <Widget>[
                          Text(category.icon),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                          Text(category.name),
                        ],
                      ),
                    );
                  }).toList(),
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
                          selectedDate, LocalNavigator(Navigator.of(context)));
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
          DateTime expenseDate, LocalNavigator navigator) {
        store.dispatch(AddExpense(
            name: name,
            amount: amount,
            category: category,
            expenseDate: expenseDate,
            navigator: navigator));
      },
    );
  }
}
