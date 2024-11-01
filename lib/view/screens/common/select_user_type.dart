import 'package:dairy_direct/utils/colors.dart';
import 'package:dairy_direct/view/screens/admin/admin_login_screen.dart';
import 'package:dairy_direct/view/widgets/custom_text.dart';
import 'package:dairy_direct/view/widgets/user_type_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectUserTypeScreen extends StatelessWidget {
  const SelectUserTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            text: 'Select User Type',
            fontSize: 25,
            color: AppColors.textColor,
          ),
          GestureDetector(
            onTap: () {
              
            },
            child: const UserTypeWidget(
                text: 'Shop', icon: Icons.storefront_outlined,),
          ),
          const UserTypeWidget(text: 'Salesman', icon: Icons.person_2_outlined),
          GestureDetector(
              onTap: () {
                Get.to(() => AdminLoginScreen());
              },
              child: const UserTypeWidget(
                  text: 'Operation Unit',
                  icon: Icons.business_center_outlined)),
        ],
      ),
    );
  }
}
