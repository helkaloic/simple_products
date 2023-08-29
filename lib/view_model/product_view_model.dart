import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_products/config/network/api_provider.dart';
import 'package:simple_products/models/product_model.dart';
import 'package:simple_products/utils/navigator.dart';

class ProductViewModel extends ChangeNotifier {
  final NavigatorService navigationService;

  ProductViewModel(this.navigationService) {
    getAllProducts();
  }

  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final desController = TextEditingController();
  final stockController = TextEditingController();

  List<ProductModel>? products;
  String? _imageName;

  getAllProducts() async {
    navigationService.showLoader();

    final response = await ApiProvider().get('/products');
    if (response != null) {
      final result = response["products"] as List<dynamic>;
      products = result.map((e) => ProductModel.fromMap(e)).toList();
      navigationService.back();
      notifyListeners();
    }
  }

  createProduct() async {
    navigationService.showLoader();

    final model = ProductModel(
      title: titleController.text.trim(),
      description: desController.text.trim(),
      price: int.parse(priceController.text),
      stock: int.parse(stockController.text),
    );

    final response = await ApiProvider().post('/products/add', model.toMap());
    if (response != null) {
      navigationService.back();
      clearAllText();
      navigationService.back();
    }
  }

  imagePicker() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      _imageName = image.name;
      debugPrint(_imageName);
    }
  }

  clearAllText() {
    titleController.clear();
    priceController.clear();
    desController.clear();
    stockController.clear();
  }
}
