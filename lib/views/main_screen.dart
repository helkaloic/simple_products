import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_products/views/components/custom_navigation_bar_view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.nagivationShell});

  final StatefulNavigationShell nagivationShell;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.nagivationShell,
      extendBody: true,
      bottomNavigationBar: CustomNavigationBar(
        width: MediaQuery.of(context).size.width,
        onClick: _navigator,
      ),
    );
  }

  void _navigator(int index) {
    widget.nagivationShell.goBranch(
      index,
      initialLocation: index == widget.nagivationShell.currentIndex,
    );
  }
}
