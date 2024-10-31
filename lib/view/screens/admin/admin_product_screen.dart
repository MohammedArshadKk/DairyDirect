import 'package:dairy_direct/utils/colors.dart';
import 'package:dairy_direct/view/screens/admin/add_product.dart';
import 'package:dairy_direct/view/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminProductScreen extends StatelessWidget {
  const AdminProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddProduct());
        },
        child: const Icon(Icons.add),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 5, childAspectRatio: 0.8),
        itemCount: 8,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 5),
            child: CustomContainer(
              height: 300,
              width: 100,
              color: const Color(0xFFF2F4F7),
              borderColor:
                  Border.all(color: const Color.fromARGB(255, 229, 226, 226)),
              borderRadius: BorderRadius.circular(8),
            ),
          );
        },
      ),
    );
  }
}
