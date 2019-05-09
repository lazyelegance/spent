import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:spent/actions/expenses_actions.dart';
import 'package:spent/middleware/db_middleware.dart';
import 'package:spent/models/app_state.dart';
import 'package:spent/presentation/home_page.dart';
import 'package:spent/reducers/app_reducer.dart';
import 'package:spent/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:redux_logging/redux_logging.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  final Store<AppState> store;

  MyApp({Key key})
      : store = Store<AppState>(
          appReducer,
          initialState: AppState.loading(),
          middleware: []
            ..addAll(createDBMiddleware(
                FirestoreService(fireStore: Firestore.instance)))
            ..add(new LoggingMiddleware.printer()),
        ),
        super(key: key) {
    store.dispatch(GetExpenses());
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: widget.store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Spent',
        theme: ThemeData(
          fontFamily: 'Fira Mono',
          primarySwatch: Colors.blueGrey,
        ),
        home: HomePage(title: 'Spent'),
      ),
    );
  }
}
