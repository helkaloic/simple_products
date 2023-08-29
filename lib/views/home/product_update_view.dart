import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:simple_products/config/theme/theme.dart';
import 'package:simple_products/models/product_model.dart';
import 'package:simple_products/utils/constants.dart';
import 'package:simple_products/utils/utils.dart';
import 'package:simple_products/view_model/product_view_model.dart';
import 'package:simple_products/views/components/custom_text_field_view.dart';

class ProductUpdateView extends StatefulWidget {
  const ProductUpdateView({super.key, required this.product});

  final ProductModel product;

  @override
  State<ProductUpdateView> createState() => _ProductUpdateViewState();
}

class _ProductUpdateViewState extends State<ProductUpdateView> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.deepBlack,
      appBar: topAppBar(),
      body: addingForm(),
    );
  }

  AppBar topAppBar() {
    return AppBar(
      title: Text(
        'Update Product',
        style: AppTheme.bigTitle,
      ),
      backgroundColor: AppColor.cardGrey,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () => context.pop(),
        child: Container(
          padding: const EdgeInsets.only(left: SMALL_PADDING),
          child: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
    );
  }

  Widget addingForm() {
    final viewModel = context.watch<ProductViewModel>();
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(MEDIUM_PADDING),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextFromField(
                controller: viewModel.titleController,
                hintText: 'Title',
              ),
              addHeightSpace(MEDIUM_PADDING),
              CustomTextFromField(
                controller: viewModel.priceController,
                hintText: 'Price',
                inputType: TextInputType.number,
              ),
              addHeightSpace(MEDIUM_PADDING),
              CustomTextFromField(
                controller: viewModel.desController,
                hintText: 'Description',
                maxLines: 5,
              ),
              addHeightSpace(MEDIUM_PADDING),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 4,
                    child: CustomTextFromField(
                      controller: viewModel.stockController,
                      hintText: 'Stock',
                      inputType: TextInputType.number,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () => viewModel.imagePicker(),
                      child: Container(
                        margin: const EdgeInsets.only(
                          left: SMALL_PADDING,
                        ),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColor.cardGrey,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.image_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              addHeightSpace(MEDIUM_PADDING),
              GestureDetector(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    viewModel.createProduct();
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(
                    vertical: 18,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      'Update',
                      style: AppTheme.mediumText,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
