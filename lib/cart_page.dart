import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:measterproject/auth_controller.dart';
import 'package:measterproject/main_food_page.dart';
import 'package:measterproject/small_text.dart';

import 'app_constants.dart';
import 'app_icon.dart';
import 'big_text.dart';
import 'cart_controller.dart';
import 'colors.dart';
import 'dimension.dart';
import 'no_data_page.dart';
import 'popular_product_controller.dart';
import 'recommended_product_controller.dart';
import 'route_helper.dart';

class CartPage extends StatelessWidget {
  CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            //Back Home and Cart Icon /
            Positioned(
              left: Dimensions.width20,
              right: Dimensions.width20,
              top: Dimensions.height20 * 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(
                    icon: Icons.arrow_back,
                    iconColor: Colors.white,
                    backgroundColor: AppColor.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                  SizedBox(width: Dimensions.width20 * 5),
                  GestureDetector(
                    onTap: (() {
                      Get.toNamed(RouteHelper.getInitial());
                    }),
                    child: AppIcon(
                      icon: Icons.home_outlined,
                      iconColor: Colors.white,
                      backgroundColor: AppColor.mainColor,
                      iconSize: Dimensions.iconSize24,
                    ),
                  ),
                  AppIcon(
                    icon: Icons.shopping_cart,
                    iconColor: Colors.white,
                    backgroundColor: AppColor.mainColor,
                    iconSize: Dimensions.iconSize24,
                  )
                ],
              ),
            ),
            //List of Products in Cart/
            GetBuilder<CartController>(builder: (_cartController) {
              return _cartController.getItems.length > 0
                  ? Positioned(
                      top: Dimensions.height20 * 5.5,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      bottom: 0,
                      child: SizedBox(
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: GetBuilder<CartController>(
                              builder: (cartController) {
                            var _cartList = cartController.getItems;
                            return ListView.builder(
                                itemCount: _cartList.length,
                                itemBuilder: (_, index) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                        top: Dimensions.height15),
                                    height: Dimensions.height20 * 5,
                                    width: double.maxFinite,
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            var popularIndex = Get.find<
                                                    PopularProductController>()
                                                .popularProductList
                                                .indexOf(_cartList[index]
                                                    .productModel!);
                                            if (popularIndex >= 0) {
                                              Get.toNamed(
                                                RouteHelper.getPopularFood(
                                                    popularIndex, 'cartpage'),
                                              );
                                            } else {
                                              var recommendedIndex = Get.find<
                                                      RecommendedProductController>()
                                                  .recommendedProductList
                                                  .indexOf(_cartList[index]
                                                      .productModel!);
                                              if (recommendedIndex < 0) {
                                                Get.snackbar("History product",
                                                    "Product review is not available for history products",
                                                    backgroundColor:
                                                        AppColor.mainColor,
                                                    colorText: Colors.white);
                                              } else {
                                                Get.toNamed(RouteHelper
                                                    .getRecommendedFood(
                                                        recommendedIndex,
                                                        'cartpage'));
                                              }
                                            }
                                          },
                                          // Image Container/
                                          child: Container(
                                            width: Dimensions.width20 * 5,
                                            height: Dimensions.height20 * 5,
                                            margin: EdgeInsets.only(
                                                bottom: Dimensions.height10),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius20),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    AppConstants.baseUrl +
                                                        AppConstants.uploadUrl +
                                                        cartController
                                                            .getItems[index]
                                                            .img!),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: Dimensions.width10),
                                        // ************** Image List Details **************/
                                        Expanded(
                                          child: SizedBox(
                                            height: Dimensions.height20 * 5,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                BigText(
                                                    text: cartController
                                                        .getItems[index].name!,
                                                    color: Colors.black54),
                                                SmallText(
                                                    text: "Spicy",
                                                    color: Colors.black54),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    BigText(
                                                      text: cartController
                                                          .getItems[index]
                                                          .price!
                                                          .toString(),
                                                      color: Colors.redAccent,
                                                    ),
                                                    //  ************** Add or Remove Number of Product from the Cart **************
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                        top:
                                                            Dimensions.height10,
                                                        bottom:
                                                            Dimensions.height10,
                                                        left:
                                                            Dimensions.width10 /
                                                                3,
                                                        right:
                                                            Dimensions.width10 /
                                                                2.5,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                Dimensions
                                                                    .radius20),
                                                        color: Colors.white,
                                                      ),
                                                      child: Row(children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            cartController.addItem(
                                                                _cartList[index]
                                                                    .productModel!,
                                                                -1);

                                                            print(
                                                                "One Item decrease from the cart remove button");
                                                          },
                                                          child: Icon(
                                                              Icons.remove,
                                                              color: AppColor
                                                                  .signColor),
                                                        ),
                                                        SizedBox(
                                                            width: Dimensions
                                                                    .width10 /
                                                                2.5),
                                                        //show number of  product in the cart from inCartItem in cart icon
                                                        BigText(
                                                            text: _cartList[
                                                                    index]
                                                                .quantity!
                                                                .toString()),
                                                        SizedBox(
                                                          width: Dimensions
                                                                  .width10 /
                                                              2.5,
                                                        ),
                                                        GestureDetector(
                                                            onTap: () {
                                                              cartController.addItem(
                                                                  _cartList[
                                                                          index]
                                                                      .productModel!,
                                                                  1);
                                                              print(
                                                                  "One Item increase from the cart add button");
                                                            },
                                                            child: Icon(
                                                                Icons.add,
                                                                color: AppColor
                                                                    .signColor)),
                                                      ]),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                });
                          }),
                        ),
                      ),
                    )
                  : NoDataPage(
                      text: "Your Cart is empty",
                    );
            }),
          ],
        ),
        bottomNavigationBar: GetBuilder<CartController>(
          builder: (cartController) {
            return Container(
              height: Dimensions.bottomHeightBar,
              padding: EdgeInsets.only(
                  top: Dimensions.height30,
                  bottom: Dimensions.height30,
                  left: Dimensions.width20,
                  right: Dimensions.width20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius20 * 2),
                    topLeft: Radius.circular(Dimensions.radius20 * 2)),
                color: AppColor.buttonBackgroundColor,
              ),
              child: cartController.getItems.length > 0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            top: Dimensions.height20,
                            bottom: Dimensions.height20,
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                          ),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: Dimensions.width10),
                              BigText(
                                  text: "\$ " +
                                      cartController.totalAmount.toString()),
                              SizedBox(width: Dimensions.width10),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (Get.find<AuthController>().userLoggedIn()) {
                              cartController.addToHistoy();
                            } else {
                              Get.toNamed(RouteHelper.getSignInPage());
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                top: Dimensions.height20,
                                bottom: Dimensions.height20,
                                left: Dimensions.width20,
                                right: Dimensions.width20),
                            child: BigText(
                              text: "Checkout",
                              color: Colors.white,
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                              color: AppColor.mainColor,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(),
            );
          },
        ));
  }
}
