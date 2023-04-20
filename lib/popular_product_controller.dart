import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:measterproject/colors.dart';
import 'package:measterproject/popular_product_repo.dart';

import 'cart_controller.dart';
import 'cart_model.dart';
import 'products_model.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  late CartController _cart;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;
  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      print('got products');
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {}
  }

  void setQuantity(bool isIncreament) {
    if (isIncreament) {
      _quantity = checkQuantity(_quantity + 1);
      //   print("number of items" + _quantity.toString());
    } else {
      _quantity = checkQuantity(_quantity - 1);
      // print('decrement' + _quantity.toString());
    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar("Item count", "You can't reduce more !",
          colorText: Colors.white, backgroundColor: AppColor.mainColor);
      return 0;
    } else if ((_inCartItems + quantity) > 20) {
      Get.snackbar("Item count", "You can't add more !",
          colorText: Colors.white, backgroundColor: AppColor.mainColor);
      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;

    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);
    //print("exist or not " + exist.toString());

    if (exist) {
      _inCartItems = _cart.getQuantity(product);
    }
    // print("The quantity in the cart is" + inCartItems.toString());
  }

  void addItems(ProductModel product) {
    // if (quantity > 0) {
    _cart.addItem(product, _quantity);
    _inCartItems = _cart.getQuantity(product);
    _quantity = 0;
    _cart.items.forEach((key, value) {
      print("The id is " +
          value.toString() +
          "The quantity is " +
          value.quantity.toString());
    });
    /*} else {
      Get.snackbar(
          "Item count", "You should at least add an item in the cart !",
          colorText: Colors.white, backgroundColor: AppColor.mainColor);
    }*/
    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
