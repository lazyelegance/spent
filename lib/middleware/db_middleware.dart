import 'package:redux/redux.dart';
import 'package:spent/actions/expenses_actions.dart';
import 'package:spent/models/app_state.dart';
import 'package:spent/services/firestore_service.dart';

List<Middleware<AppState>> createDBMiddleware(
    FirestoreService firestoreService) {
  final getExpenses = _createGetExpenses(firestoreService);

  return [
    new TypedMiddleware<AppState, GetExpenses>(getExpenses),
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
