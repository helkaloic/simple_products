import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_products/config/theme/theme.dart';

class NoProductView extends StatelessWidget {
  const NoProductView({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
        style: AppTheme.bigTitle.copyWith(
          fontSize: 40.sp,
          color: AppColor.cardLightGrey,
        ),
      ),
    );
  }
}
