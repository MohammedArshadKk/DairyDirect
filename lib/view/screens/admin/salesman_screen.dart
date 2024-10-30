import 'package:dairy_direct/utils/colors.dart';
import 'package:dairy_direct/view/screens/admin/add_salesman_screen.dart';
import 'package:dairy_direct/view/widgets/custom_container.dart';
import 'package:dairy_direct/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalesmanScreen extends StatelessWidget {
  const SalesmanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: AppColors.primaryColor,
        iconTheme: IconThemeData(color: AppColors.secondaryColor),
        title: Center(
          child: SizedBox(
            width: 150,
            child: CustomText(
              text: "Salesman",
              fontWeight: FontWeight.bold,
              color: AppColors.secondaryColor,
              fontSize: 25,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Get.to(()=>AddSalesmanScreen());
      } , child: const Icon(Icons.add),), 
      body: CustomContainer(
        height: 25,
        width: double.infinity,
        color: AppColors.primaryColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
    );
  }
}
