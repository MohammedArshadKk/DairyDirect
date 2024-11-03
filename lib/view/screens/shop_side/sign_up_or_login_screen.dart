import 'package:dairy_direct/view/screens/shop_side/create_shop_side_account.dart';
import 'package:dairy_direct/view/screens/shop_side/shop_login.dart';
import 'package:dairy_direct/view/widgets/user_type_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpOrLoginScreen extends StatelessWidget {
  const SignUpOrLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Get.to(() => ShopLogin());
            },
            child: const UserTypeWidget(
              text: 'Login',
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => CreateShopSideAccount());
            },
            child: const UserTypeWidget(
              text: 'Sgin Up',
            ),
          )
        ],
      ),
    );
  }
}
