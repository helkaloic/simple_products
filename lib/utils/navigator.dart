import 'package:flutter/material.dart';
import 'package:simple_products/config/theme/theme.dart';

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

  showMessage(String text) {
    ScaffoldMessenger.of(navigationKey.currentContext!).showSnackBar(
      SnackBar(
        backgroundColor: AppColor.deepBlack.withOpacity(.8),
        content: Text(
          text,
          style: AppTheme.mediumText,
        ),
      ),
    );
  }

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
