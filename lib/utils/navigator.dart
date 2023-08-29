import 'package:flutter/material.dart';
import 'package:simple_products/config/theme/theme.dart';
import 'package:simple_products/models/product_model.dart';
import 'package:simple_products/views/components/custom_bottom_sheet_view.dart';

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

  showBottomSheet(ProductModel model) {
    showModalBottomSheet(
      context: navigationKey.currentContext!,
      isScrollControlled: true, // Allow dynamic height
      builder: (context) => CustomBottomSheetView(product: model),
    );
  }

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
