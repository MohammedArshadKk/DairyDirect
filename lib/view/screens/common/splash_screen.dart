import 'dart:async';
import 'dart:developer';


import 'package:dairy_direct/utils/colors.dart';
import 'package:dairy_direct/utils/images.dart';
import 'package:dairy_direct/view/screens/admin/admin_home.dart';
import 'package:dairy_direct/view/screens/common/select_user_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 2),
      () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        if (prefs.getBool('admin') == true) {
          Get.off(() => const AdminHomeScreen());
        } else {
          Get.off(() => const SelectUserTypeScreen());
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
