import 'package:flutter/material.dart';

Type typeOf<T>() => T;

typedef Json = Map<String, dynamic>;
typedef JsonList = List<dynamic>;

class Global {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static BuildContext get context => navigatorKey.currentState!.context;
}
