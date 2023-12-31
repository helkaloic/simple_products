import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:simple_products/config/theme/theme.dart';
import 'package:simple_products/utils/constants.dart';
import 'package:simple_products/utils/utils.dart';
import 'package:simple_products/view_model/product_view_model.dart';
import 'package:simple_products/views/components/no_products_view.dart';
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
      builder: (context, viewModel, child) {
        final bookmarks = viewModel.products!.where((e) => e.bookmark).toList();
        return Padding(
          padding: const EdgeInsets.all(SMALL_PADDING),
          child: bookmarks.isEmpty
              ? const NoProductView(
                  text: "No bookmarks found",
                )
              : GridView.builder(
                  itemCount: bookmarks.length,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: size.width / getWidthScale(size.width),
                    mainAxisExtent: 500.h,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemBuilder: (context, index) {
                    final product = bookmarks[index];
                    return ProductCardView(
                      size: size,
                      model: product,
                      onFunction: () => viewModel.setBookmark(product),
                    );
                  },
                ),
        );
      },
    );
  }

  AppBar topAppBar() {
    return AppBar(
      toolbarHeight: APP_BAR.h,
      title: Text.rich(TextSpan(
        children: [
          TextSpan(
            text: 'Bookmark',
            style: AppTheme.bigTitle.copyWith(
              fontSize: TEXT_LARGE.sp,
            ),
          ),
          // TextSpan(
          //   text: 'Bookmark',
          //   style: AppTheme.bigTitle.copyWith(
          //     color: AppColor.textGrey,
          //   ),
          // ),
        ],
      )),
      backgroundColor: AppColor.cardGrey,
      centerTitle: true,
      actions: [
        Consumer<ProductViewModel>(
          builder: (context, viewModel, child) => GestureDetector(
            onTap: () => viewModel.removeAllBookmark(),
            child: Container(
              margin: const EdgeInsets.only(right: MEDIUM_PADDING),
              child: Icon(
                Icons.bookmark_remove_outlined,
                color: Colors.white,
                size: ICON_SIZE.w,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
