import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_products/config/theme/theme.dart';
import 'package:simple_products/utils/constants.dart';
import 'package:simple_products/utils/utils.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({super.key});

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.deepBlack,
      appBar: topAppBar(),
      body: gridviewProducts(size),
      floatingActionButton: addButton(),
    );
  }

  FloatingActionButton addButton() {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: AppColor.lightBlue,
      shape: const CircleBorder(),
      child: const Icon(Icons.add),
    );
  }

  AppBar topAppBar() {
    return AppBar(
      title: Text('Products', style: AppTheme.bigTitle),
      backgroundColor: AppColor.cardGrey,
      centerTitle: true,
    );
  }

  Widget gridviewProducts(Size size) {
    return Padding(
      padding: const EdgeInsets.all(SMALL_PADDING),
      child: GridView.builder(
        itemCount: 6,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: size.width / 2,
          mainAxisExtent: 400.h,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemBuilder: (context, index) => Card(
          color: AppColor.cardLightGrey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CachedNetworkImage(
                imageUrl: 'https://i.dummyjson.com/data/products/1/1.jpg',
                fit: BoxFit.cover,
                width: size.width / 2,
                height: 300.h,
                errorWidget: (context, url, error) => errorImage(),
                placeholder: (context, url) => loadingImage(),
              ),
              addHeightSpace(SMALL_PADDING),
              Text(
                'data',
                style: AppTheme.mediumText.copyWith(fontSize: 32.sp),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
