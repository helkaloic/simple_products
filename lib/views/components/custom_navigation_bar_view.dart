// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_products/config/theme/theme.dart';
import 'package:simple_products/utils/utils.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({
    super.key,
    required this.width,
    required this.onClick,
  });

  final double width;
  final void Function(int index) onClick;

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  final List<NavIconLabel> navs = [
    NavIconLabel(icon: Icons.home_outlined, label: 'Home'),
    NavIconLabel(icon: Icons.search, label: 'Search'),
    NavIconLabel(icon: Icons.bookmark_border_outlined, label: 'Bookmark'),
  ];

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135.h,
      width: widget.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColor.deepBlack.withOpacity(.75),
            AppColor.deepBlack,
          ],
          stops: const [0.0, .65],
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          tileMode: TileMode.mirror,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: navs
            .mapIndexed(
              (index, e) => GestureDetector(
                onTap: () {
                  widget.onClick(index);
                  setState(() => _current = index);
                },
                child: Opacity(
                  opacity: _current == index ? 1.0 : 0.8,
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          e.icon,
                          size: 60.h,
                          color: Colors.white.withOpacity(.65),
                        ),
                        addHeightSpace(8.h),
                        Text(
                          e.label,
                          style: TextStyle(
                            fontSize: 26.sp,
                            color: Colors.white,
                            fontWeight: _current == index
                                ? FontWeight.w700
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class NavIconLabel {
  IconData icon;
  String label;
  NavIconLabel({
    required this.icon,
    required this.label,
  });
}
