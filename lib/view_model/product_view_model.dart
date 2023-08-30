import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_products/config/network/api_provider.dart';
import 'package:simple_products/models/product_model.dart';
import 'package:simple_products/utils/navigator.dart';
import 'package:simple_products/utils/utils.dart';
import 'package:simple_products/views/home/product_update_view.dart';

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
  final searchController = TextEditingController();

  List<ProductModel> carts = [];
  List<ProductModel> searchProducts = [];
  List<ProductModel> checkoutList = [];
  List<ProductModel>? products;
  String? _imageName;

  checkoutProduct() {
    navigationService.showLoader();

    for (ProductModel product in checkoutList) {
      if (carts.contains(product) && products!.contains(product)) {
        carts.remove(product);

        // substract the stock
        for (ProductModel pm in products!) {
          if (pm.id == product.id) {
            pm.stock = pm.stock! - 1;
            break;
          }
        }
      }
    }
    checkoutList.clear();

    Future.delayed(const Duration(seconds: 1), () {
      navigationService.back();
      navigationService.showMessage('Completed your order!');
    });

    notifyListeners();
  }

  int get calculatedPrice {
    int price = 0;
    for (var element in checkoutList) {
      price += element.price ?? 0;
    }
    return price;
  }

  addOrRemoveCheckoutList(ProductModel product) {
    if (checkoutList.contains(product)) {
      checkoutList.remove(product);
    } else {
      checkoutList.add(product);
    }

    notifyListeners();
  }

  searchProduct(String text) {
    if (text.isNotEmpty) {
      searchProducts = products!
          .where(
            (p) =>
                (p.title ?? '').toLowerCase().contains(text.toLowerCase()) ||
                (p.brand ?? '').toLowerCase().contains(text.toLowerCase()) ||
                (p.price ?? '')
                    .toString()
                    .toLowerCase()
                    .contains(text.toLowerCase()) ||
                (p.category ?? '').toLowerCase().contains(text.toLowerCase()),
          )
          .toList();
    } else {
      searchProducts.clear();
    }
    notifyListeners();
  }

  clearSearchResult() {
    searchController.clear();
    searchProducts.clear();
    setUnfocusEditText();
    notifyListeners();
  }

  removeAllCart() {
    carts.clear();
    checkoutList.clear();
    navigationService.showMessage('Removed all product in cart!');
    notifyListeners();
  }

  removeFromCart(ProductModel product) {
    if (carts.contains(product)) {
      carts.remove(product);
      navigationService.showMessage('Removed ${product.title} from cart');

      // also remove from checkout list
      if (checkoutList.contains(product)) {
        checkoutList.remove(product);
      }

      notifyListeners();
    } else {
      navigationService.showMessage('Already removed from cart!');
    }
  }

  addToCart(ProductModel product) {
    if (!carts.contains(product)) {
      carts.add(product);
      notifyListeners();
    } else {
      navigationService.showMessage('Already added to cart!');
    }
  }

  deleteProduct(ProductModel product, int index) async {
    navigationService.showLoader();

    final response = await _api.delete('/products/${product.id}');
    navigationService.back();
    if (response != null) {
      products!.removeAt(index);
      navigationService.showMessage('Removed: ${product.title}');

      // also remove from cart
      if (carts.contains(product)) {
        carts.remove(product);
      }
      // also remove from checkout
      if (checkoutList.contains(product)) {
        checkoutList.remove(product);
      }

      notifyListeners();
    }
  }

  navigateToEdit(ProductModel model) {
    clearAllText();
    titleController.text = model.title ?? '';
    priceController.text = '${model.price ?? ''}';
    desController.text = model.description ?? '';
    stockController.text = '${model.stock ?? ''}';

    navigationService.push(ProductUpdateView(product: model));
  }

  getAllProducts() async {
    final response = await _api.get('/products');
    if (response != null) {
      final result = response["products"] as List<dynamic>;
      products = result.map((e) => ProductModel.fromMap(e)).toList();
      notifyListeners();
    }
  }

  updateProduct(int id) async {
    navigationService.showLoader();

    final model = ProductModel(
      title: titleController.text.trim(),
      description: desController.text.trim(),
      price: int.parse(priceController.text),
      stock: int.parse(stockController.text),
    );

    final response = await _api.put('/products/$id', model.toMap());
    navigationService.back();
    if (response != null) {
      setUnfocusEditText();
      clearAllText();

      // getAllProducts(); // use this instead in the real api
      _updateProductLists(id, model);

      navigationService.back();
    }
  }

  _updateProductLists(int id, ProductModel model) {
    for (ProductModel pm in products!) {
      if (pm.id == id) {
        pm.title = model.title;
        pm.price = model.price;
        pm.description = model.description;
        pm.stock = model.stock;
        break;
      }
    }
    notifyListeners();
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
      getAllProducts();
      navigationService.showMessage('Created: ${model.title}!');
    }
  }

  removeAllBookmark() {
    for (ProductModel pm in products!) {
      if (pm.bookmark) {
        pm.bookmark = false;
      }
    }
    navigationService.showMessage('Removed all bookmark!');
    notifyListeners();
  }

  setBookmark(ProductModel product) {
    for (ProductModel pm in products!) {
      if (pm.id == product.id) {
        pm.bookmark = !pm.bookmark;
        break;
      }
    }
    notifyListeners();
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
