import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_products/config/theme/theme.dart';
import 'package:simple_products/utils/constants.dart';
import 'package:simple_products/utils/utils.dart';

class ProductCardView extends StatelessWidget {
  const ProductCardView({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.cardLightGrey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: CachedNetworkImage(
              imageUrl: 'https://i.dummyjson.com/data/products/1/1.jpg',
              fit: BoxFit.cover,
              width: size.width / 2,
              height: 300.h,
              errorWidget: (context, url, error) => errorImage(),
              placeholder: (context, url) => loadingImage(),
            ),
          ),
          addHeightSpace(SMALL_PADDING),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'iPhone X pro',
                        style: AppTheme.mediumText.copyWith(
                          fontSize: 32.sp,
                          color: AppColor.textGrey,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      addHeightSpace(SMALL_PADDING / 4),
                      Text(
                        r'$100',
                        style: AppTheme.mediumText.copyWith(fontSize: 40.sp),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: Icon(
                    Icons.bookmark_border,
                    color: AppColor.textGrey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
