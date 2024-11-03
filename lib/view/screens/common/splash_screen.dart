import 'dart:async';
import 'dart:developer';

import 'package:dairy_direct/controller/shop_auth_controller.dart';
import 'package:dairy_direct/utils/colors.dart';
import 'package:dairy_direct/utils/images.dart';
import 'package:dairy_direct/view/screens/admin/admin_home.dart';
import 'package:dairy_direct/view/screens/common/select_user_type.dart';
import 'package:dairy_direct/view/screens/shop_side/shop_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    Timer(
      const Duration(seconds: 2),
      () async {
        final shopAuth =
            Provider.of<ShopAuthController>(context, listen: false);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        if (_auth.currentUser != null) {
          await shopAuth.checkShopExist(_auth.currentUser!.uid);
          if (shopAuth.isShopExist) {
            Get.offAll(() =>  ShopHome());
          }
        } else if (prefs.getBool('admin') == true) {
          Get.offAll(() => const AdminHomeScreen());
        } else {
          Get.offAll(() => const SelectUserTypeScreen());
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AppImages.spalshImage),
        ),
      ),
    );
  }
}
