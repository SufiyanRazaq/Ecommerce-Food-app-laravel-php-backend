import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:measterproject/account_widget.dart';
import 'package:measterproject/app_icon.dart';
import 'package:measterproject/auth_controller.dart';
import 'package:measterproject/big_text.dart';
import 'package:measterproject/cart_controller.dart';
import 'package:measterproject/colors.dart';
import 'package:measterproject/custom_loader.dart';
import 'package:measterproject/dimension.dart';
import 'package:measterproject/icon.dart';
import 'package:measterproject/route_helper.dart';
import 'package:measterproject/user_controller.dart';

class AccountPage extends StatelessWidget {
  AccountPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (userLoggedIn) {
      Get.find<UserController>().getUserInfo();
      print("User has logged in");
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.mainColor,
          title: Center(
            child: BigText(
              text: "Profile",
              size: 23,
              color: Colors.white,
            ),
          ),
        ),
        body: GetBuilder<UserController>(
          builder: (userController) {
            return userLoggedIn
                ? (userController.isLoading
                    ? Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(top: Dimensions.height30),
                        child: Column(
                          children: [
                            /*   Container(
                          height: 40,
                          color: AppColor.mainColor,
                          child: Center(
                            child: BigText(
                              text: "Profile",
                              size: 23,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),*/
                            AppIcon1(
                              icon: Icons.person,
                              backgroundColor: AppColor.mainColor,
                              iconColor: Colors.white,
                              iconSize:
                                  Dimensions.height20 + Dimensions.height20,
                              size: Dimensions.height15 * 8,
                            ),
                            SizedBox(
                              height: Dimensions.height15,
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.person,
                                        backgroundColor: AppColor.mainColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 8,
                                        size: Dimensions.height10 * 4,
                                      ),
                                      bigText: BigText(
                                          text: userController.userModel.name),
                                    ),
                                    SizedBox(
                                      height: Dimensions.height10,
                                    ),
                                    AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.phone,
                                        backgroundColor: AppColor.yellowColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 10,
                                        size: Dimensions.height10 * 4,
                                      ),
                                      bigText: BigText(
                                          text: userController.userModel.phone),
                                    ),
                                    SizedBox(
                                      height: Dimensions.height15,
                                    ),
                                    AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.email,
                                        backgroundColor: AppColor.yellowColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 10,
                                        size: Dimensions.height10 * 4,
                                      ),
                                      bigText: BigText(
                                        text: userController.userModel.email,
                                        size: 18,
                                      ),
                                    ),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.location_on,
                                        backgroundColor: AppColor.yellowColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 10,
                                        size: Dimensions.height10 * 4,
                                      ),
                                      bigText:
                                          BigText(text: "Pakistan, Karachi"),
                                    ),
                                    SizedBox(
                                      height: Dimensions.height15,
                                    ),
                                    AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.message_outlined,
                                        backgroundColor: Colors.redAccent,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 10,
                                        size: Dimensions.height10 * 4,
                                      ),
                                      bigText: BigText(text: "Messages"),
                                    ),
                                    SizedBox(
                                      height: Dimensions.height15,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (Get.find<AuthController>()
                                            .userLoggedIn()) {
                                          Get.find<AuthController>()
                                              .clearSharedData();
                                          Get.find<CartController>().clear();
                                          Get.find<CartController>()
                                              .clearCartHistory();
                                          Get.toNamed(
                                              RouteHelper.getSignInPage());
                                        } else {
                                          print("You logged out");
                                        }
                                      },
                                      child: AccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.logout,
                                          backgroundColor: Colors.redAccent,
                                          iconColor: Colors.white,
                                          iconSize:
                                              Dimensions.height10 * 5 / 10,
                                          size: Dimensions.height10 * 4,
                                        ),
                                        bigText: BigText(text: "Logout"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : CustomLoader())
                : Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: double.maxFinite,
                            height: Dimensions.font20 * 9,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        "assets/signintocontinue.png"))),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(RouteHelper.getSignInPage());
                            },
                            child: Container(
                              width: double.maxFinite,
                              height: Dimensions.height20 * 5,
                              margin: EdgeInsets.only(
                                  left: Dimensions.width20,
                                  right: Dimensions.width20),
                              decoration: BoxDecoration(
                                  color: AppColor.mainColor,
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius20)),
                              child: Center(
                                child: BigText(
                                  text: "Sign In",
                                  color: Colors.white,
                                  size: Dimensions.font26,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
          },
        ));
  }
}
