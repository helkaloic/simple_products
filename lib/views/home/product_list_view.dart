import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:simple_products/config/routes/route_manager.dart';
import 'package:simple_products/config/theme/theme.dart';
import 'package:simple_products/utils/constants.dart';
import 'package:simple_products/view_model/product_view_model.dart';

import '../components/product_card_view.dart';

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
    );
  }

  AppBar topAppBar() {
    return AppBar(
      title: Text.rich(TextSpan(
        children: [
          TextSpan(
            text: 'Simple',
            style: AppTheme.bigTitle,
          ),
          TextSpan(
            text: 'Products',
            style: AppTheme.bigTitle.copyWith(
              color: AppColor.textGrey,
            ),
          ),
        ],
      )),
      backgroundColor: AppColor.cardGrey,
      centerTitle: true,
      actions: [
        GestureDetector(
          onTap: () => context.push(AppRoute.addProduct),
          child: Container(
            margin: const EdgeInsets.only(right: MEDIUM_PADDING),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget gridviewProducts() {
    final size = MediaQuery.of(context).size;
    final viewModel = context.watch<ProductViewModel>();
    return Padding(
      padding: const EdgeInsets.all(SMALL_PADDING),
      child: viewModel.products == null
          ? Container()
          : GridView.builder(
              itemCount: viewModel.products!.length,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: size.width / 2,
                mainAxisExtent: 450.h,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemBuilder: (context, index) => ProductCardView(
                size: size,
                model: viewModel.products![index],
              ),
            ),
    );
  }
}
