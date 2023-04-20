// once we create the class for api client we'll call that class inside init method adn then call init method from our main function

import 'package:get/get.dart';
import 'package:measterproject/auth_controller.dart';
import 'package:measterproject/auth_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_client.dart';
import 'app_constants.dart';
import 'cart_controller.dart';
import 'cart_repo.dart';
import 'popular_product_controller.dart';
import 'popular_product_repo.dart';
import 'recommended_product_controller.dart';
import 'recommended_product_repo.dart';
import 'user_controller.dart';
import 'user_repo.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
//Api Client
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()));
  Get.lazyPut(
      () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
// Repository
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));

//Controllers
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));

  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
}
