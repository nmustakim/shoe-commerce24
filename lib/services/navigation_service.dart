import 'package:flutter/material.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Future<dynamic> navigateToReplacement(Route route) {
    return navigatorKey.currentState!.pushReplacement(route);
  }

  static Future<dynamic> navigateAndRemoveUntil(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(routeName, (route) => false, arguments: arguments);
  }

  static Future<dynamic> navigateToNamedRoute(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  static popNavigate() {
    return navigatorKey.currentState!.pop();
  }
}
