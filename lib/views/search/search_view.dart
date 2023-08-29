import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:simple_products/config/theme/theme.dart';
import 'package:simple_products/utils/constants.dart';
import 'package:simple_products/view_model/product_view_model.dart';
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
        child: GridView.builder(
          itemCount: viewModel.searchProducts.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: size.width / 2,
            mainAxisExtent: 450.h,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          itemBuilder: (context, index) {
            final product = viewModel.searchProducts[index];
            return GestureDetector(
              onTap: () =>
                  viewModel.navigationService.showBottomSheet(product, index),
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
      toolbarHeight: 70,
      flexibleSpace: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: AppColor.cardLightGrey,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Consumer<ProductViewModel>(
            builder: (context, viewModel, child) => TextFormField(
              controller: viewModel.searchController,
              onChanged: (value) => viewModel.searchProduct(value),
              style: AppTheme.mediumText.copyWith(
                color: AppColor.textGrey.withOpacity(.85),
                fontWeight: FontWeight.bold,
              ),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                prefixIcon: Container(
                  padding: const EdgeInsets.only(left: 15, right: 10),
                  child: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
                hintText: 'Search by name, brand, etc',
                hintStyle: AppTheme.mediumText.copyWith(
                  color: AppColor.textGrey.withOpacity(.5),
                  fontWeight: FontWeight.bold,
                ),
                border: InputBorder.none,
                suffixIcon: GestureDetector(
                  onTap: () => viewModel.clearSearchResult(),
                  child: const Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
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
