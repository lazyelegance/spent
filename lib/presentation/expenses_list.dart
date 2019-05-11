import 'package:flutter/material.dart';
import 'package:spent/models/expense.dart';

class ExpensesList extends StatelessWidget {
  final List<Expense> expenses;
  const ExpensesList({Key key, this.expenses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return expenses != null ? _buildListView() : Container();
  }

  Widget _buildListView() {
    return ListView.builder(
      key: Key('expenses_list'),
      itemCount: expenses.length,
      itemBuilder: (BuildContext context, int index) {
        final expense = expenses[index];
        return _buildListItem(expense);
      },
    );
  }

  Widget _buildListItem(Expense expense) => Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  expense.name,
                  style: TextStyle(fontSize: 21),
                ),
                Text(
                  expense.amount.toString(),
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            Text(expense.category)
          ],
        ),
      );
}
