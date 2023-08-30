import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:simple_products/config/theme/theme.dart';
import 'package:simple_products/models/product_model.dart';
import 'package:simple_products/utils/constants.dart';
import 'package:simple_products/utils/utils.dart';
import 'package:simple_products/view_model/product_view_model.dart';
import 'package:simple_products/views/components/custom_rating_bar_view.dart';

class CustomBottomSheetView extends StatelessWidget {
  const CustomBottomSheetView({
    super.key,
    required this.product,
    required this.index,
  });

  final ProductModel product;
  final int index;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      decoration: const BoxDecoration(
        color: AppColor.cardGrey,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MEDIUM_PADDING),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              topTitle(),
              addHeightSpace(MEDIUM_PADDING),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  imageSlider(size),
                  addWidthSpace(MEDIUM_PADDING),
                  productSideInfo(),
                ],
              ),
              addHeightSpace(MEDIUM_PADDING),
              titleAndPriceProduct(),
              addHeightSpace(SMALL_PADDING),
              productDescription(),
              addHeightSpace(MEDIUM_PADDING),
              buttons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buttons() {
    return Consumer<ProductViewModel>(
      builder: (context, viewModel, child) {
        final isAddedToCart = viewModel.carts.contains(product);
        return Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: isAddedToCart
                    ? () => viewModel.removeFromCart(product)
                    : () => viewModel.addToCart(product),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  decoration: BoxDecoration(
                    color: isAddedToCart ? AppColor.textGrey : AppColor.green,
                    borderRadius: BorderRadius.circular(SMALL_PADDING),
                  ),
                  child: Center(
                    child: Text(
                      isAddedToCart ? 'Remove from cart' : 'Add to cart',
                      style: AppTheme.mediumText.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColor.deepBlack,
                        fontSize: 35.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            addWidthSpace(MEDIUM_PADDING),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  viewModel.deleteProduct(product, index);
                  viewModel.navigationService.back();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.cardLightGrey,
                    borderRadius: BorderRadius.circular(SMALL_PADDING),
                  ),
                  child: Center(
                    child: Text(
                      'Delete',
                      style: AppTheme.mediumText.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 35.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget productDescription() {
    return Consumer<ProductViewModel>(
      builder: (context, value, child) => Text(
        product.description ?? '',
        overflow: TextOverflow.ellipsis,
        maxLines: 6,
        textAlign: TextAlign.justify,
        style: AppTheme.bigTitle.copyWith(
          color: AppColor.textGrey,
          fontWeight: FontWeight.normal,
          fontSize: 32.sp,
          height: 1.75,
        ),
      ),
    );
  }

  Widget titleAndPriceProduct() {
    return Consumer<ProductViewModel>(
      builder: (context, viewModel, child) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 4,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.bigTitle.copyWith(
                    fontSize: 45.sp,
                  ),
                ),
                addHeightSpace(SMALL_PADDING),
                Text(
                  '\$${product.price ?? ''}',
                  style: AppTheme.bigTitle.copyWith(
                    fontSize: 56.sp,
                    color: AppColor.green,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => viewModel.setBookmark(product),
            child: Padding(
              padding: const EdgeInsets.only(
                top: SMALL_PADDING,
                bottom: SMALL_PADDING,
              ),
              child: Icon(
                product.bookmark
                    ? Icons.bookmark_outlined
                    : Icons.bookmark_border_outlined,
                color: AppColor.textGrey,
                size: (ICON_SIZE * 1.75).w,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget productSideInfo() {
    return Consumer<ProductViewModel>(
      builder: (context, viewModel, child) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sideInfoLine('Brand: ', '${product.brand}'),
            addHeightSpace(SMALL_PADDING),
            sideInfoLine('Discount: ', '${product.discountPercentage}%'),
            addHeightSpace(SMALL_PADDING),
            sideInfoLine('Stock: ', '${product.stock}'),
            addHeightSpace(SMALL_PADDING),
            RatingBarView(
              rating: product.rating ?? 0.0,
              size: 48.w,
            ),
          ],
        ),
      ),
    );
  }

  RichText sideInfoLine(String title, String value) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: AppTheme.mediumText.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColor.textGrey,
              fontSize: 35.sp,
            ),
          ),
          TextSpan(
            text: value,
            style: AppTheme.mediumText.copyWith(
              fontSize: 35.sp,
            ),
          ),
        ],
      ),
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget imageSlider(Size size) {
    return Expanded(
      child: Container(
        width: size.width / 2,
        height: SLIDER_SIZE,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColor.deepBlack,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: CarouselSlider.builder(
            itemCount: product.images!.length,
            itemBuilder: (context, index, realIndex) => CachedNetworkImage(
              imageUrl: product.images![index],
              errorWidget: (context, url, error) => errorImage(),
              placeholder: (context, url) => loadingImage(),
              height: SLIDER_SIZE,
              fit: BoxFit.cover,
            ),
            options: CarouselOptions(
              height: SLIDER_SIZE,
              viewportFraction: 1,
              autoPlay: true,
            ),
          ),
        ),
      ),
    );
  }

  Widget topTitle() {
    return Consumer<ProductViewModel>(
      builder: (context, viewModel, child) => Stack(
        children: [
          GestureDetector(
            onTap: () => viewModel.navigationService.back(),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.close,
                color: AppColor.textGrey,
                size: ICON_SIZE.w,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => viewModel.navigateToEdit(product),
            child: Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.edit,
                color: AppColor.textGrey,
                size: ICON_SIZE.w,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              'Product details',
              style: AppTheme.bigTitle.copyWith(
                fontSize: TEXT_LARGE.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
