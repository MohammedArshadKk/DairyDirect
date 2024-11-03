import 'package:dairy_direct/utils/alert.dart';
import 'package:dairy_direct/view/screens/admin/admin_product_screen.dart';
import 'package:dairy_direct/view/screens/admin/salesman_screen.dart';
import 'package:dairy_direct/view/screens/common/select_user_type.dart';
import 'package:dairy_direct/view/widgets/custom_container.dart';
import 'package:dairy_direct/view/widgets/custom_text.dart';
import 'package:dairy_direct/view/widgets/grid_itom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/colors.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.secondaryColor),
        titleTextStyle: TextStyle(
          color: AppColors.secondaryColor,
          fontSize: 25,
          fontWeight: FontWeight.w600,
        ),
        toolbarHeight: 100,
        backgroundColor: AppColors.primaryColor,
        title: const CustomText(text: 'Home'),
        actions: [
          IconButton(
            onPressed: () async {
              showMyDialog(context, () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool('admin', false);
                Get.offAll(() => const SelectUserTypeScreen());
              }, '"Are you sure you want to logout?"');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          CustomContainer(
            height: 25,
            width: double.infinity,
            color: AppColors.primaryColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                padding: const EdgeInsets.only(top: 20),
                children: [
                  GridViewItomWidget(
                    text: 'Order',
                    onTap: () {},
                    icon: Icons.shopping_cart_outlined,
                  ),
                  GridViewItomWidget(
                    text: 'Products',
                    onTap: () {
                      Get.to(() => AdminProductScreen()); 

                    },
                    icon: Icons.inventory_2_outlined,
                  ),
                  GridViewItomWidget(
                    text: 'Salesmen',
                    onTap: () {
                      Get.to(() => SalesmanScreen());
                    },
                    icon: Icons.person_2_outlined,
                  ),
                  GridViewItomWidget(
                    text: 'Shops',
                    onTap: () {},
                    icon: Icons.storefront_outlined,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
