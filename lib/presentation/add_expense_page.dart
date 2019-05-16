import 'package:flutter/material.dart';
import 'package:spent/containers/expense_form.dart';

class AddExpensePage extends StatelessWidget {
  const AddExpensePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add an Expense'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[ExpenseForm()],
        ),
      ),
    );
  }
}
