import 'package:dairy_direct/model/prodect_model.dart';
import 'package:dairy_direct/utils/colors.dart';
import 'package:dairy_direct/view/screens/shop_side/product_details.dart';
import 'package:dairy_direct/view/widgets/custom_container.dart';
import 'package:dairy_direct/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key, required this.products, this.onTap});
  final List<ProductModel> products;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 5, childAspectRatio: 0.8),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 5),
          child: GestureDetector(
            onTap: () {
              Get.to(() => ProductDetailsScreen(productModel: product));
            },
            child: CustomContainer(
              height: 300,
              width: 100,
              color: const Color(0xFFF2F4F7),
              borderColor:
                  Border.all(color: const Color.fromARGB(255, 229, 226, 226)),
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
    );
  }
}
