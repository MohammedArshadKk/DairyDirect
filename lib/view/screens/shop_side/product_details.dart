import 'package:dairy_direct/model/prodect_model.dart';
import 'package:dairy_direct/utils/colors.dart';
import 'package:dairy_direct/view/widgets/custom_container.dart';
import 'package:dairy_direct/view/widgets/custom_text.dart';
import 'package:dairy_direct/view/widgets/quantity_add_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({super.key, required this.productModel});
  final ProductModel productModel;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
      ),
      backgroundColor: AppColors.secondaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CustomContainer(
                height: 300,
                width: double.infinity,
                child: Center(
                  child: Image.network(
                    productModel.imgUrl,
                    filterQuality: FilterQuality.high,
                    height: 270,
                  ),
                ),
              ),
              SizedBox(
                width: 500,
                child: CustomText(
                  text: productModel.title,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textColor,
                ),
              ),
              SizedBox(
                width: 400,
                child: CustomText(
                  text: "₹${productModel.price} / ${productModel.unit}",
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.blueGrey,
                ),
              ),
              SizedBox(
                width: 400,
                child: CustomText(
                  text: productModel.quantity > 0 ? 'in stock' : 'out of stock',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: productModel.quantity > 0
                      ? const Color.fromARGB(255, 38, 178, 110)
                      : Colors.red,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 400,
                child: CustomText(
                  text: "Description",
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textColor,
                ),
              ),
              SizedBox(
                width: 500,
                child: CustomText(
                  text: productModel.description,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.blueGrey,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: GestureDetector(
          onTap: () {
            quantityAddDialog(
              context,
              productModel.quantity,
              _auth.currentUser!.uid,
              productModel.id!,
              productModel.imgUrl,
              productModel.title,
            );
          },
          child: CustomContainer(
            width: double.infinity,
            height: 70,
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(30),
            child: Center(
              child: CustomText(
                text: 'Order Now',
                color: AppColors.secondaryColor,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
