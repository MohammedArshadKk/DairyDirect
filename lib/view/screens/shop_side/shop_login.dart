import 'package:dairy_direct/controller/shop_auth_controller.dart';
import 'package:dairy_direct/functions/show_message.dart';
import 'package:dairy_direct/utils/colors.dart';
import 'package:dairy_direct/view/screens/shop_side/shop_home.dart';
import 'package:dairy_direct/view/widgets/custom_container.dart';
import 'package:dairy_direct/view/widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ShopLogin extends StatelessWidget {
  ShopLogin({
    super.key,
  });

  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Consumer<ShopAuthController>(
        builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomText(
                  text: 'Login your Shop Account',
                  fontSize: 25,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 25,
                ),
                value.isLoading
                    ? const CircularProgressIndicator()
                    : GestureDetector(
                        onTap: () async {
                          try {
                            await value.signInWithGoogle();
                            if (value.user != null) {
                              await value
                                  .checkShopExist(_auth.currentUser!.uid);
                              if (value.isShopExist) {
                                Get.offAll(() => ShopHome());
                              } else {
                                showMessage(
                                    "Your account was not found. Please create an account.",
                                    context);
                              }
                            }
                          } catch (e) {
                            value.isLoading = false;
                          }
                        },
                        child: CustomContainer(
                            height: 70,
                            width: double.infinity,
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                            child: Center(
                              child: CustomText(
                                text: 'Sgin in with google',
                                fontSize: 18,
                                textAlign: TextAlign.center,
                                color: AppColors.secondaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      )
              ],
            ),
          );
        },
      ),
    );
  }
}
