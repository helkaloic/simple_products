import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_products/config/network/api_provider.dart';
import 'package:simple_products/models/product_model.dart';
import 'package:simple_products/utils/navigator.dart';
import 'package:simple_products/utils/utils.dart';

class ProductViewModel extends ChangeNotifier {
  final NavigatorService navigationService;

  ProductViewModel(this.navigationService) {
    getAllProducts();
  }

  final _api = ApiProvider();

  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final desController = TextEditingController();
  final stockController = TextEditingController();

  List<ProductModel>? products;
  String? _imageName;

  deleteProduct(ProductModel product, int index) async {
    navigationService.showLoader();

    final response = await _api.delete('/products/${product.id}');
    navigationService.back();
    if (response != null) {
      products!.removeAt(index);
      navigationService.showMessage('Deleted ${product.title}');
      notifyListeners();
    }
  }

  getAllProducts() async {
    final response = await _api.get('/products');
    if (response != null) {
      final result = response["products"] as List<dynamic>;
      products = result.map((e) => ProductModel.fromMap(e)).toList();
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

    final response = await _api.post('/products/add', model.toMap());
    navigationService.back();
    if (response != null) {
      setUnfocusEditText();
      clearAllText();
      navigationService.showMessage('Product created!');
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
