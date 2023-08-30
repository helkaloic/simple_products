import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:simple_products/config/theme/theme.dart';
import 'package:simple_products/utils/constants.dart';
import 'package:simple_products/utils/utils.dart';
import 'package:simple_products/view_model/product_view_model.dart';
import 'package:simple_products/views/components/no_products_view.dart';
import 'package:simple_products/views/components/product_card_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
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
        child: viewModel.searchController.text.isEmpty
            ? const NoProductView(text: 'Type something to search')
            : viewModel.searchProducts.isEmpty
                ? const NoProductView(text: 'No products found')
                : GridView.builder(
                    itemCount: viewModel.searchProducts.length,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent:
                          size.width / getWidthScale(size.width),
                      mainAxisExtent: 500.h,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                    itemBuilder: (context, index) {
                      final product = viewModel.searchProducts[index];
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
    );
  }

  AppBar topAppBar() {
    return AppBar(
      backgroundColor: AppColor.cardGrey,
      toolbarHeight: APP_BAR.h,
      flexibleSpace: SafeArea(
        child: Container(
          margin: EdgeInsets.all(20.h),
          decoration: BoxDecoration(
            color: AppColor.cardLightGrey,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Consumer<ProductViewModel>(
            builder: (context, viewModel, child) => TextFormField(
              controller: viewModel.searchController,
              onChanged: (value) => viewModel.searchProduct(value.trim()),
              style: AppTheme.mediumText.copyWith(
                color: AppColor.textGrey.withOpacity(.85),
                fontWeight: FontWeight.bold,
                fontSize: 35.sp,
              ),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                prefixIcon: Container(
                  padding: EdgeInsets.only(left: 25.w, right: 25.w),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: ICON_SIZE.w,
                  ),
                ),
                hintText: 'Search by name, brand, etc',
                hintStyle: AppTheme.mediumText.copyWith(
                  color: AppColor.textGrey.withOpacity(.5),
                  fontWeight: FontWeight.bold,
                  fontSize: 35.sp,
                ),
                border: InputBorder.none,
                isDense: true,
                suffixIcon: GestureDetector(
                  onTap: () => viewModel.clearSearchResult(),
                  child: Padding(
                    padding: EdgeInsets.only(right: 15.w),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: ICON_SIZE.w,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
