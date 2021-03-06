import 'package:spent/models/expense.dart';
import 'package:spent/navigation/navigation.dart';

class GetExpenses {}

class LoadExpenses {
  final List<Expense> expenses;

  LoadExpenses({this.expenses});
}

class AddExpense {
  final String name, category, amount;
  final DateTime expenseDate;
  final LocalNavigator navigator;

  AddExpense(
      {this.name,
      this.category,
      this.amount,
      this.expenseDate,
      this.navigator});
}

class AddExpenseSuccess {}
