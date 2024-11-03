import 'package:dairy_direct/controller/add_prodect_controller.dart';
import 'package:dairy_direct/utils/alert.dart';
import 'package:dairy_direct/utils/colors.dart';
import 'package:dairy_direct/view/screens/common/history_screen.dart';
import 'package:dairy_direct/view/screens/common/select_user_type.dart';
import 'package:dairy_direct/view/widgets/custom_text.dart';
import 'package:dairy_direct/view/widgets/grid_loading.dart';
import 'package:dairy_direct/view/widgets/product_grid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ShopHome extends StatefulWidget {
  ShopHome({super.key});

  @override
  State<ShopHome> createState() => _ShopHomeState();
}

class _ShopHomeState extends State<ShopHome> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<AddProdectController>(context, listen: false).getAllProduct();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final addProductController = Provider.of<AddProdectController>(context);
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() =>  HistoryOrderScreen());
              }, 
              icon: Icon(
                Icons.history,
                color: AppColors.secondaryColor,
              )),
          IconButton(
              onPressed: () async {
                await showMyDialog(context, () async {
                  await _auth.signOut();
                }, 'you want to logout?');
                Get.offAll(() => const SelectUserTypeScreen());
              },
              icon: Icon(
                Icons.logout_rounded,
                color: AppColors.secondaryColor,
              )),
        ],
      ),
      body: addProductController.isLoading
          ? const GridLoadingWidget()
          : addProductController.products.isEmpty
              ? const Center(
                  child: CustomText(
                    text: 'No Products',
                    fontSize: 25,
                  ),
                )
              : ProductGrid(
                  products: addProductController.products,
                ),
    );
  }
}
