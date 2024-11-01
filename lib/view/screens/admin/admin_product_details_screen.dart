import 'package:dairy_direct/controller/add_prodect_controller.dart';
import 'package:dairy_direct/model/prodect_model.dart';
import 'package:dairy_direct/utils/alert.dart';
import 'package:dairy_direct/utils/colors.dart';
import 'package:dairy_direct/view/screens/admin/edt_product.dart';
import 'package:dairy_direct/view/widgets/custom_container.dart';
import 'package:dairy_direct/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AdminProductDetailsScreen extends StatelessWidget {
  const AdminProductDetailsScreen({super.key, required this.productModel});
  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => EditProduct(productModel: productModel));
              },
              icon: Icon(
                Icons.edit_note,
                color: AppColors.primaryColor,
                size: 30,
              )),
          IconButton(
              onPressed: () async {
                await showMyDialog(context, () async {
                  Provider.of<AddProdectController>(context, listen: false)
                      .deleteProduct(productModel.id!);
                }, 'Delete Product');
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
                size: 25,
              ))
        ],
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
              SizedBox(
                width: 400,
                child: CustomText(
                  text: "Quantity",
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textColor,
                ),
              ),
              SizedBox(
                width: 500,
                child: CustomText(
                  text: "${productModel.quantity} Packs",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.blueGrey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
