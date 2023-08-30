import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_products/config/theme/theme.dart';
import 'package:simple_products/utils/constants.dart';

class CustomTextFromField extends StatelessWidget {
  const CustomTextFromField({
    super.key,
    required this.controller,
    this.hintText = '',
    this.maxLines = 1,
    this.inputType = TextInputType.text,
  });

  final String hintText;
  final int maxLines;
  final TextInputType inputType;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: SMALL_PADDING,
        horizontal: MEDIUM_PADDING,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.cardGrey,
      ),
      child: TextFormField(
        controller: controller,
        validator: (value) =>
            (value == null || value.isEmpty) ? 'Required' : null,
        style: AppTheme.mediumText.copyWith(
          fontSize: 35.sp,
        ),
        maxLines: maxLines,
        keyboardType: inputType,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: AppTheme.mediumText.copyWith(
            color: AppColor.textGrey,
          ),
        ),
      ),
    );
  }
}
