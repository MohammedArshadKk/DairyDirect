import 'package:dairy_direct/controller/add_prodect_controller.dart';
import 'package:dairy_direct/controller/shop_auth_controller.dart';
import 'package:dairy_direct/functions/show_message.dart';
import 'package:dairy_direct/model/shop_model.dart';
import 'package:dairy_direct/utils/colors.dart';
import 'package:dairy_direct/view/screens/shop_side/sign_in_with_google_screen.dart';
import 'package:dairy_direct/view/widgets/custom_container.dart';
import 'package:dairy_direct/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CreateShopSideAccount extends StatelessWidget {
  CreateShopSideAccount({super.key});
  final TextEditingController shopNameController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
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
            child: Consumer<ShopAuthController>(
              builder: (context, value, child) {
                return Column(
                  children: [
                    Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(10),
                      child: GestureDetector(
                        onTap: () {
                          value.pickShopImage();
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
                        controller: shopNameController,
                        maxLines: null,
                        obscureText: false,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.secondaryColor,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 242, 239, 239))),
                            labelText: 'Enter Shop Name'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Shop Name';
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
                        keyboardType: TextInputType.number,
                        controller: phoneNoController,
                        obscureText: false,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.secondaryColor,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 242, 239, 239))),
                            labelText: 'Enter Phone Number'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Phone Number';
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
                        GestureDetector(
                          onTap: () async {},
                          child: CustomContainer(
                            height: 60,
                            width: 165,
                            color: AppColors.secondaryColor,
                            borderColor: Border.all(),
                            borderRadius: BorderRadius.circular(8),
                            child: const Center(
                              child: Icon(
                                Icons.location_on,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (value.image == null) {
                              showMessage('Please Add Shop Image', context);
                            } else {
                              if (formKey.currentState!.validate()) {
                                final ShopModel shopModel = ShopModel(
                                    shopName: shopNameController.text,
                                    shopImg: value.image!.path,
                                    phoneNo: phoneNoController.text,
                                    shopLocation: '',
                                    uid: '',
                                    email: '');
                                Get.to(() => SignInWithGoogleScreen(
                                    shopModel: shopModel));
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
                              text: 'next',
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
