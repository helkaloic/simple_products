import 'package:flutter/material.dart';

class NavigatorService {
  late GlobalKey<NavigatorState> navigationKey;

  static NavigatorService instance = NavigatorService();

  NavigatorService() {
    navigationKey = GlobalKey<NavigatorState>();
  }

  push(Widget page) => navigationKey.currentState!.push(
        MaterialPageRoute(builder: (context) => page),
      );

  back() => navigationKey.currentState!.pop();

  showLoader() {
    Future.delayed(
      Duration.zero,
      () => showDialog(
        context: navigationKey.currentContext!,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      ),
    );
  }
}
