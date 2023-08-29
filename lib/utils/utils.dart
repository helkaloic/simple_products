import 'package:flutter/material.dart';
import 'package:simple_products/config/theme/theme.dart';

Widget addHeightSpace(double height) => SizedBox(height: height);

Widget addWidthSpace(double width) => SizedBox(width: width);

Widget loadingImage() => Container(
      decoration: BoxDecoration(
        color: AppColor.cardGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(
        child: CircularProgressIndicator(color: AppColor.textGrey),
      ),
    );

Widget errorImage() => Container(
      decoration: BoxDecoration(
        color: AppColor.cardGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(
        child:
            Icon(Icons.image_not_supported_outlined, color: AppColor.textGrey),
      ),
    );

setUnfocusEditText() => FocusManager.instance.primaryFocus?.unfocus();
