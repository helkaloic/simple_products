import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      builder: (context, viewModel, child) {
        final bookmarks = viewModel.products!.where((e) => e.bookmark).toList();
        return Padding(
          padding: const EdgeInsets.all(SMALL_PADDING),
          child: GridView.builder(
            itemCount: bookmarks.length,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: size.width / 2,
              mainAxisExtent: 450.h,
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
      title: Text.rich(TextSpan(
        children: [
          TextSpan(
            text: 'Bookmark',
            style: AppTheme.bigTitle,
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
              child: const Icon(
                Icons.bookmark_remove_outlined,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
