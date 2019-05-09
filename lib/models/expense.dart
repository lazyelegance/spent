class Expense {
  final String expenseId, name, category;
  final double amount;

  Expense({this.expenseId, this.name, this.category, this.amount});

  @override
  String toString() {
    return 'Expense: ($expenseId, $name, $amount, $category)';
  }
}
