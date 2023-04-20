import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:measterproject/colors.dart';

import 'cart_model.dart';
import 'cart_repo.dart';
import 'products_model.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  // ignore: prefer_final_fields
  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;
  List<CartModel> storageItems = [];
  void addItem(ProductModel productModel, int quantity) {
    var totalQuantity = 0;
    // Upadting the map
    if (_items.containsKey(productModel.id!)) {
      _items.update(productModel.id!, (value) {
        // value is an object for this product model
        // old object value + new one and check on it
        totalQuantity = value.quantity! + quantity;
        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity:
              value.quantity! + quantity, // update & pass new quantity-> cart
          isExist: true,
          time: DateTime.now().toString(),
          productModel: productModel,
        );
      });
      if (totalQuantity <= 0) {
        _items.remove(productModel.id);
      }
    }
    // Adding new items in the map
    else {
      if (quantity > 0) {
        _items.putIfAbsent(productModel.id!, () {
          return CartModel(
            id: productModel.id,
            name: productModel.name,
            price: productModel.price,
            img: productModel.img,
            quantity: quantity,
            isExist: true,
            time: DateTime.now().toString(),
            productModel: productModel,
          );
        });
      } else {}
    }
    cartRepo.addToCartList(getItems);
    update();
  }

  bool existInCart(ProductModel productModel) {
    if (_items.containsKey(productModel.id)) {
      return true;
    }
    return false;
  }

  // try to get the quantity if it exist or not
  int getQuantity(ProductModel productModel) {
    var qunatity = 0;
    if (_items.containsKey(productModel.id)) {
      _items.forEach((key, value) {
        if (key == productModel.id) {
          qunatity = value.quantity!;
        }
      });
    }
    return qunatity;
  }

  // returns a field not a function
  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get totalAmount {
    var total = 0;

    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });
    return total;
  }

  List<CartModel> getCartData() {
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items) {
    storageItems = items;
    //print("Length of cart items " + storageItems.length.toString());
    for (int i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(
          storageItems[i].productModel!.id!, () => storageItems[i]);
    }
  }

  void addToHistoy() {
    cartRepo.addToCartHistoryList();
    clear();
  }

  void clear() {
    _items = {};
    update();
  }

  List<CartModel> getCartHistoryList() {
    return cartRepo.getCartHistoryList();
  }

  set setItems(Map<int, CartModel> setItems) {
    _items = {};
    _items = setItems;
  }

  void addToCartList() {
    cartRepo.addToCartList(getItems);
    update();
  }

  void clearCartHistory() {
    cartRepo.cartHistoryList();
    update();
  }
}
