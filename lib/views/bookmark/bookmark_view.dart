import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:simple_products/config/theme/theme.dart';
import 'package:simple_products/utils/constants.dart';
import 'package:simple_products/view_model/product_view_model.dart';
import 'package:simple_products/views/components/product_card_view.dart';

class BookmarkView extends StatefulWidget {
  const BookmarkView({super.key});

  @override
  State<BookmarkView> createState() => _BookmarkViewState();
}

class _BookmarkViewState extends State<BookmarkView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.deepBlack,
      appBar: topAppBar(),
      body: gridviewProducts(),
    );
  }

  Widget gridviewProducts() {
    final size = MediaQuery.of(context).size;
    return Consumer<ProductViewModel>(
      builder: (context, viewModel, child) => Padding(
        padding: const EdgeInsets.all(SMALL_PADDING),
        child: GridView.builder(
          itemCount: viewModel.carts.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: size.width / 2,
            mainAxisExtent: 450.h,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          itemBuilder: (context, index) {
            final product = viewModel.carts[index];
            return ProductCardView(
              size: size,
              model: product,
              isCartView: true,
              onFunction: () => viewModel.removeFromCart(product),
            );
          },
        ),
      ),
    );
  }

  AppBar topAppBar() {
    return AppBar(
      title: Text.rich(TextSpan(
        children: [
          TextSpan(
            text: 'Shopping',
            style: AppTheme.bigTitle,
          ),
          TextSpan(
            text: 'Cart',
            style: AppTheme.bigTitle.copyWith(
              color: AppColor.textGrey,
            ),
          ),
        ],
      )),
      backgroundColor: AppColor.cardGrey,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () => context.pop(),
        child: Container(
          padding: const EdgeInsets.only(left: SMALL_PADDING),
          child: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      actions: [
        Consumer<ProductViewModel>(
          builder: (context, viewModel, child) => GestureDetector(
            onTap: () => viewModel.removeAllCart(),
            child: Container(
              margin: const EdgeInsets.only(right: MEDIUM_PADDING),
              child: const Icon(
                Icons.remove_shopping_cart_outlined,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
