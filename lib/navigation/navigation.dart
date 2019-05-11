import 'package:flutter/material.dart';

class LocalNavigator {
  final NavigatorState _navigator;
  LocalNavigator(this._navigator);

  goBack() {
    _navigator.pop();
  }
}
