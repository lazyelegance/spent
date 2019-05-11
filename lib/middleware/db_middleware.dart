import 'package:redux/redux.dart';
import 'package:spent/actions/expenses_actions.dart';
import 'package:spent/models/app_state.dart';
import 'package:spent/services/firestore_service.dart';

List<Middleware<AppState>> createDBMiddleware(
    FirestoreService firestoreService) {
  final getExpenses = _createGetExpenses(firestoreService);
  final createAddExpense = _createAddExpense(firestoreService);

  return [
    new TypedMiddleware<AppState, GetExpenses>(getExpenses),
    new TypedMiddleware<AppState, AddExpense>(createAddExpense),
  ];
}

Middleware<AppState> _createGetExpenses(FirestoreService firestoreService) {
  return (Store store, action, NextDispatcher next) {
    next(action);

    TODO:
    firestoreService.getExpenses().listen((expenses) {
      store.dispatch(LoadExpenses(expenses: expenses));
    });
  };
}

Middleware<AppState> _createAddExpense(FirestoreService firestoreService) {
  return (Store store, action, NextDispatcher next) {
    next(action);

    firestoreService.addExpense(action.name, action.amount, action.category);
    Future.delayed(Duration(milliseconds: 1500), () {
      store.dispatch(AddExpenseSuccess());
      action.navigator.goBack();
    });
  };
}
