import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:simple_products/config/routes/route_manager.dart';
import 'package:simple_products/config/theme/theme.dart';
import 'package:simple_products/utils/constants.dart';
import 'package:simple_products/utils/utils.dart';
import 'package:simple_products/view_model/product_view_model.dart';
import 'package:simple_products/views/components/product_card_view.dart';

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
      toolbarHeight: APP_BAR.h,
      title: Text.rich(TextSpan(
        children: [
          TextSpan(
            text: 'Simple',
            style: AppTheme.bigTitle.copyWith(
              fontSize: TEXT_LARGE.sp,
            ),
          ),
          TextSpan(
            text: 'Products',
            style: AppTheme.bigTitle.copyWith(
              color: AppColor.textGrey,
              fontSize: TEXT_LARGE.sp,
            ),
          ),
        ],
      )),
      backgroundColor: AppColor.cardGrey,
      centerTitle: true,
      leading: Consumer<ProductViewModel>(
        builder: (context, viewModel, child) => GestureDetector(
          onTap: () => context.push(AppRoute.cart),
          child: Container(
            // color: Colors.amber,
            margin: EdgeInsets.only(
              left: 20.w,
              top: 22.h,
              bottom: 22.h,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  color: Colors.transparent,
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.white,
                    size: 50.h,
                  ),
                ),
                if (viewModel.carts.isNotEmpty)
                  Align(
                    alignment: Alignment.topRight,
                    child: ClipOval(
                      child: Container(
                        color: Colors.redAccent,
                        height: 30.h,
                        width: 30.h,
                        child: Center(
                          child: Text(
                            viewModel.carts.length.toString(),
                            style: AppTheme.mediumText.copyWith(
                              fontSize: 24.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () => context.push(AppRoute.addProduct),
          child: Container(
            margin: const EdgeInsets.only(right: MEDIUM_PADDING),
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: ICON_SIZE.h,
            ),
          ),
        ),
      ],
    );
  }

  Widget gridviewProducts() {
    final size = MediaQuery.of(context).size;
    return Consumer<ProductViewModel>(
      builder: (context, viewModel, child) => RefreshIndicator(
        onRefresh: () => viewModel.getAllProducts(),
        backgroundColor: AppColor.cardGrey,
        color: AppColor.green,
        child: Padding(
          padding: const EdgeInsets.all(SMALL_PADDING),
          child: viewModel.products == null
              ? const Center(
                  child: CircularProgressIndicator(color: AppColor.textGrey),
                )
              : GridView.builder(
                  itemCount: viewModel.products!.length,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: size.width / getWidthScale(size.width),
                    mainAxisExtent: CARD_HEIGHT.h,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemBuilder: (context, index) {
                    final product = viewModel.products![index];
                    return GestureDetector(
                      onTap: () => viewModel.navigationService
                          .showBottomSheet(product, index),
                      child: ProductCardView(
                        size: size,
                        model: product,
                        onFunction: () => viewModel.setBookmark(product),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
