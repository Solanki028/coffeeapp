import 'package:flutter/material.dart';
import 'package:coffeeshop/details.dart';
import 'package:coffeeshop/home.dart';
import 'package:coffeeshop/menu.dart';
import 'package:coffeeshop/summary.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => Home(),
        "/menu": (context) => Menu(),
        "/details": (context) => Details(),
        "/summary": (context) => Summary(),
      },
      navigatorObservers: [MyRouteObserver()],
    );
  }
}

class MyRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    print('Pushed: ${route.settings.name}');
  }
}
