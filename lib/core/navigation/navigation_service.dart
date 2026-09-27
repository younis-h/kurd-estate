import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  NavigatorState? get navigator => navigatorKey.currentState;

  BuildContext? get context => navigatorKey.currentContext;

  void pop<T extends Object?>([T? result]) {
    navigator?.pop(result);
  }

  Future<T?> push<T extends Object?>(
    Route<T> route,
  ) {
    return navigator!.push(route);
  }

  Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return navigator!.pushNamed<T>(
      routeName,
      arguments: arguments,
    );
  }

  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    Object? arguments,
    TO? result,
  }) {
    return navigator!.pushReplacementNamed<T, TO>(
      routeName,
      arguments: arguments,
      result: result,
    );
  }

  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    String routeName, {
    Object? arguments,
    required RoutePredicate predicate,
  }) {
    return navigator!.pushNamedAndRemoveUntil<T>(
      routeName,
      predicate,
      arguments: arguments,
    );
  }

  void popUntil(RoutePredicate predicate) {
    navigator?.popUntil(predicate);
  }

  void popToRoot() {
    navigator?.popUntil((route) => route.isFirst);
  }
}