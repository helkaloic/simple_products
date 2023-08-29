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
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewModel = context.watch<ProductViewModel>();
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
              topTitle(viewModel),
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

  Row buttons() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
              ),
              decoration: BoxDecoration(
                color: AppColor.blue,
                borderRadius: BorderRadius.circular(SMALL_PADDING),
              ),
              child: Center(
                child: Text(
                  'Add to cart',
                  style: AppTheme.mediumText.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        addWidthSpace(MEDIUM_PADDING),
        Expanded(
          child: GestureDetector(
            onTap: () {},
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
                  'Remove',
                  style: AppTheme.mediumText.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Text productDescription() {
    return Text(
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
    );
  }

  Row titleAndPriceProduct() {
    return Row(
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
        const Padding(
          padding: EdgeInsets.only(top: SMALL_PADDING, bottom: SMALL_PADDING),
          child: Icon(
            Icons.bookmark_border_outlined,
            color: AppColor.textGrey,
            size: 36,
          ),
        ),
      ],
    );
  }

  Widget productSideInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Brand: ',
                  style: AppTheme.mediumText.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColor.textGrey,
                  ),
                ),
                TextSpan(
                  text: '${product.brand}',
                  style: AppTheme.mediumText,
                ),
              ],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          addHeightSpace(SMALL_PADDING),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Discount: ',
                  style: AppTheme.mediumText.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColor.textGrey,
                  ),
                ),
                TextSpan(
                  text: '${product.discountPercentage}%',
                  style: AppTheme.mediumText,
                ),
              ],
            ),
            overflow: TextOverflow.fade,
          ),
          addHeightSpace(SMALL_PADDING),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Stock: ',
                  style: AppTheme.mediumText.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColor.textGrey,
                  ),
                ),
                TextSpan(
                  text: '${product.stock}',
                  style: AppTheme.mediumText,
                ),
              ],
            ),
            overflow: TextOverflow.fade,
          ),
          addHeightSpace(SMALL_PADDING),
          RatingBarView(
            rating: product.rating ?? 0.0,
            size: 21,
          ),
        ],
      ),
    );
  }

  Widget imageSlider(Size size) {
    return Expanded(
      child: Container(
        width: size.width / 2,
        height: 150,
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
              height: 150,
              fit: BoxFit.cover,
            ),
            options: CarouselOptions(
              height: 150,
              viewportFraction: 1,
              autoPlay: true,
            ),
          ),
        ),
      ),
    );
  }

  Stack topTitle(ProductViewModel viewModel) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => viewModel.navigationService.back(),
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Icon(Icons.close, color: AppColor.textGrey),
          ),
        ),
        GestureDetector(
          onTap: () => viewModel.navigateToEdit(product),
          child: const Align(
            alignment: Alignment.centerRight,
            child: Icon(Icons.edit, color: AppColor.textGrey),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            'Product details',
            style: AppTheme.bigTitle.copyWith(
              fontSize: 50.sp,
            ),
          ),
        ),
      ],
    );
  }
}
