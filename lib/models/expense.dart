import 'package:spent/models/category.dart';

class Expense {
  final String expenseId, name;
  final Category category;
  final String amount;

  Expense({this.expenseId, this.name, this.category, this.amount});

  @override
  String toString() {
    return 'Expense: ($expenseId, $name, $amount, $category)';
  }
}
