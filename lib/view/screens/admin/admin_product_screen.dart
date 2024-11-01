import 'package:dairy_direct/controller/add_prodect_controller.dart';
import 'package:dairy_direct/utils/colors.dart';
import 'package:dairy_direct/view/screens/admin/add_product.dart';
import 'package:dairy_direct/view/screens/admin/admin_product_details_screen.dart';
import 'package:dairy_direct/view/widgets/custom_container.dart';
import 'package:dairy_direct/view/widgets/custom_text.dart';
import 'package:dairy_direct/view/widgets/grid_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AdminProductScreen extends StatefulWidget {
  const AdminProductScreen({super.key});

  @override
  State<AdminProductScreen> createState() => _AdminProductScreenState();
}

class _AdminProductScreenState extends State<AdminProductScreen> {
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
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddProduct());
        },
        child: const Icon(Icons.add),
      ),
      body: addProductController.isLoading
          ? const GridLoadingWidget()
          : addProductController.products.isEmpty
              ? const Center(
                  child: CustomText(
                    text: 'No Data',
                    fontSize: 25,
                  ),
                )
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      childAspectRatio: 0.8),
                  itemCount: addProductController.products.length,
                  itemBuilder: (context, index) {
                    final product = addProductController.products[index];
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 8, bottom: 5),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() =>
                              AdminProductDetailsScreen(productModel: product));
                        },
                        child: CustomContainer(
                          height: 300,
                          width: 100,
                          color: const Color(0xFFF2F4F7),
                          borderColor: Border.all(
                              color: const Color.fromARGB(255, 229, 226, 226)),
                          borderRadius: BorderRadius.circular(8),
                          child: Center(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.network(
                                    product.imgUrl,
                                    height: 100,
                                    width: 100,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: CustomText(
                                    text: product.title,
                                    fontSize: 16,
                                    textAlign: TextAlign.center,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textColor,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomText(
                                      text: " ₹${product.price} / ",
                                      fontSize: 16,
                                      color: Colors.blueGrey,
                                      textAlign: TextAlign.center,
                                    ),
                                    CustomText(
                                      text: product.unit,
                                      fontSize: 16,
                                      color: Colors.blueGrey,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
