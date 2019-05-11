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

const MaterialColor white = const MaterialColor(
  0xFFFFFFFF,
  const <int, Color>{
    50: const Color(0xFFFFFFFF),
    100: const Color(0xFFFFFFFF),
    200: const Color(0xFFFFFFFF),
    300: const Color(0xFFFFFFFF),
    400: const Color(0xFFFFFFFF),
    500: const Color(0xFFFFFFFF),
    600: const Color(0xFFFFFFFF),
    700: const Color(0xFFFFFFFF),
    800: const Color(0xFFFFFFFF),
    900: const Color(0xFFFFFFFF),
  },
);

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
            primarySwatch: white,
            cursorColor: Colors.black,
            inputDecorationTheme: InputDecorationTheme(
              labelStyle: TextStyle(color: Colors.black, fontSize: 16),
              hintStyle: TextStyle(color: Colors.black54, fontSize: 16),
              errorStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontStyle: FontStyle.italic),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red)),
              errorMaxLines: 2,
            )),
        home: HomePage(title: 'Spent'),
      ),
    );
  }
}
