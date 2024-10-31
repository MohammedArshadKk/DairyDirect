import 'package:dairy_direct/controller/add_prodect_controller.dart';
import 'package:dairy_direct/functions/show_message.dart';
import 'package:dairy_direct/model/prodect_model.dart';
import 'package:dairy_direct/utils/colors.dart';
import 'package:dairy_direct/view/widgets/custom_container.dart';
import 'package:dairy_direct/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatelessWidget {
  AddProduct({super.key});
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController unitController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
          child: Form(
            key: formKey,
            child: Consumer<AddProdectController>(
              builder: (context, value, child) {
                return Column(
                  children: [
                    Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(10),
                      child: GestureDetector(
                        onTap: () {
                          value.pickProductImage();
                        },
                        child: CustomContainer(
                          height: 350,
                          width: double.infinity,
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.secondaryColor,
                          borderColor: Border.all(
                              color: const Color.fromARGB(255, 195, 214, 223)),
                          child: Center(
                            child: value.image != null
                                ? Image.file(value.image!)
                                : const Icon(
                                    Icons.add_a_photo_outlined,
                                    size: 50,
                                  ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(8),
                      child: TextFormField(
                        controller: titleController,
                        maxLines: null,
                        obscureText: false,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.secondaryColor,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 242, 239, 239))),
                            labelText: 'Enter Product Title'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter title';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(8),
                      child: TextFormField(
                        controller: descriptionController,
                        maxLines: null,
                        obscureText: false,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.secondaryColor,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 242, 239, 239))),
                            labelText: 'Enter Product Description'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Description';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(8),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: priceController,
                              obscureText: false,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.secondaryColor,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                          color: Color.fromARGB(
                                              255, 242, 239, 239))),
                                  labelText: 'Enter Price'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Price';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(8),
                            child: TextFormField(
                              controller: unitController,
                              obscureText: false,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.secondaryColor,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                          color: Color.fromARGB(
                                              255, 242, 239, 239))),
                                  labelText: 'Enter Unit'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Unit Ml/Kg/g/L';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(8),
                            child: TextFormField(
                              controller: quantityController,
                              obscureText: false,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.secondaryColor,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                          color: Color.fromARGB(
                                              255, 242, 239, 239))),
                                  labelText: 'Enter quantity'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Quantity';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        value.isLoading
                            ?const CircularProgressIndicator()
                            : GestureDetector(
                                onTap: () async {
                                  if (value.image == null) {
                                    showMessage(
                                        'Please Add Product Image', context);
                                  } else {
                                    if (formKey.currentState!.validate()) {
                                      await value.uploadProductImage();
                                      final ProductModel productModel =
                                          ProductModel(
                                              title: titleController.text,
                                              description:
                                                  descriptionController.text,
                                              price: priceController.text,
                                              unit: unitController.text,
                                              quantity: int.parse(
                                                  quantityController.text),
                                              imgUrl: value.productImageUrl!);
                                      value.addProductToTable(productModel);
                                      if (value.iscompleted) {
                                        titleController.clear();
                                        descriptionController.clear();
                                        priceController.clear();
                                        unitController.clear();
                                        quantityController.clear(); 
                                      }
                                    }
                                  }
                                },
                                child: CustomContainer(
                                  height: 60,
                                  width: 165,
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(8),
                                  child: Center(
                                      child: CustomText(
                                    text: 'Add Product',
                                    color: AppColors.secondaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )),
                                ),
                              )
                      ],
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
