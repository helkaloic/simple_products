import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:simple_products/config/theme/theme.dart';
import 'package:simple_products/utils/constants.dart';
import 'package:simple_products/view_model/product_view_model.dart';
import 'package:simple_products/views/components/product_card_view.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
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
      builder: (context, viewModel, child) => Container(
        padding: const EdgeInsets.all(SMALL_PADDING),
        child: Stack(
          children: [
            GridView.builder(
              itemCount: viewModel.carts.length,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: size.width / 2,
                mainAxisExtent: 450.h,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemBuilder: (context, index) {
                final product = viewModel.carts[index];
                return GestureDetector(
                  onTap: () => viewModel.addOrRemoveCheckoutList(product),
                  child: Stack(
                    children: [
                      ProductCardView(
                        size: size,
                        model: product,
                        isCartView: true,
                        onFunction: () => viewModel.removeFromCart(product),
                      ),
                      if (viewModel.checkoutList.isNotEmpty)
                        Align(
                          alignment: Alignment.topLeft,
                          child: Checkbox(
                            onChanged: (value) {},
                            value: viewModel.checkoutList.contains(product),
                            fillColor:
                                const MaterialStatePropertyAll(AppColor.green),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
            if (viewModel.checkoutList.isNotEmpty)
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: size.width,
                  margin: EdgeInsets.only(bottom: 130.h),
                  padding: const EdgeInsets.symmetric(
                    vertical: SMALL_PADDING * 1.5,
                    horizontal: SMALL_PADDING * 1.5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.cardGrey.withOpacity(.95),
                    borderRadius: BorderRadius.circular(SMALL_PADDING),
                    // boxShadow: const [
                    //   BoxShadow(
                    //     color: AppColor.deepBlack,
                    //     offset: Offset(0, 1),
                    //     blurRadius: 5,
                    //   ),
                    // ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(TextSpan(children: [
                        TextSpan(
                          text: 'Total:  ',
                          style: AppTheme.bigTitle.copyWith(
                            fontSize: 40.sp,
                            // color: AppColor.textGrey,
                          ),
                        ),
                        TextSpan(
                          text: '\$${viewModel.calculatedPrice}',
                          style: AppTheme.bigTitle.copyWith(
                            fontSize: 45.sp,
                            color: AppColor.green,
                          ),
                        ),
                      ])),
                      GestureDetector(
                        onTap: () => viewModel.checkoutProduct(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColor.green,
                            boxShadow: const [
                              BoxShadow(
                                color: AppColor.cardGrey,
                                offset: Offset(0, 1),
                                blurRadius: 3,
                              ),
                            ],
                          ),
                          child: Text(
                            'Checkout',
                            style: AppTheme.mediumText.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColor.cardGrey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
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
