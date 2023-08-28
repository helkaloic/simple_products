import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_products/config/routes/route_manager.dart';
import 'package:simple_products/config/theme/theme.dart';
import 'package:simple_products/utils/constants.dart';

import 'components/product_card_view.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({super.key});

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.deepBlack,
      appBar: topAppBar(),
      body: gridviewProducts(),
      floatingActionButton: addButton(),
    );
  }

  FloatingActionButton addButton() {
    return FloatingActionButton(
      onPressed: () => context.push(AppRoute.addProduct),
      backgroundColor: AppColor.lightBlue,
      shape: const CircleBorder(),
      child: const Icon(Icons.add),
    );
  }

  AppBar topAppBar() {
    return AppBar(
      title: Text(
        'Products',
        style: AppTheme.bigTitle,
      ),
      backgroundColor: AppColor.cardGrey,
      centerTitle: true,
    );
  }

  Widget gridviewProducts() {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(SMALL_PADDING),
      child: GridView.builder(
        itemCount: 10,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: size.width / 2,
          mainAxisExtent: 450.h,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemBuilder: (context, index) => ProductCardView(size: size),
      ),
    );
  }
}
