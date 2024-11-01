import 'dart:developer';

import 'package:dairy_direct/controller/add_salesman_controller.dart';
import 'package:dairy_direct/functions/encrypt.dart';
import 'package:dairy_direct/functions/show_message.dart';
import 'package:dairy_direct/model/salesman_model.dart';
import 'package:dairy_direct/utils/colors.dart';
import 'package:dairy_direct/view/widgets/custom_container.dart';
import 'package:dairy_direct/view/widgets/custom_text.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddSalesmanScreen extends StatelessWidget {
  AddSalesmanScreen({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passIdController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final EncryptData encryptData = EncryptData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: AppColors.primaryColor,
        iconTheme: IconThemeData(color: AppColors.secondaryColor),
      ),
      body: Consumer<AddSalesmanController>(
        builder: (context, value, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                CustomContainer(
                  height: 200,
                  width: double.infinity,
                  color: AppColors.primaryColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: GestureDetector(
                          onTap: () => value.pickProfile(),
                          child: CustomContainer(
                            height: 180,
                            width: 150,
                            color: AppColors.secondaryColor,
                            borderRadius: BorderRadius.circular(30),
                            child: Center(
                              child: value.image == null
                                  ? const Icon(
                                      Icons.add_photo_alternate_outlined,
                                      size: 50,
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Image.file(
                                        value.image!,
                                        width: 180,
                                        height: 180,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nameController,
                          obscureText: false,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter Salesman Name'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: passIdController,
                          obscureText: true,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Create Salesman Id'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Operation Salesman Id';
                            }
                            if (value.length < 6) {
                              return 'Please enter 6 digts  salesman Id';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: value.isLoading
                      ? const CircularProgressIndicator()
                      : GestureDetector(
                          onTap: () async {
                           
                            if (value.image == null) {
                              showMessage('Please add profile', context);
                            } else {
                              if (formKey.currentState!.validate()) {
                                await value.uploadProfile();
                                // String encryptPass = encryptData
                                //     .encryptText(passIdController.text);
                                // log(encryptData
                                //     .decryptText(encryptPass));
                                SalesmanModel salesmanModel = SalesmanModel(
                                    name: nameController.text,
                                    pass: passIdController.text,
                                    imgUrl: value.profile!);
                                await value.addToTable(salesman: salesmanModel);

                                if (value.iscompleted) {
                                  showMessage(
                                      "Salesman adding completed", context);
                                }
                                value.fetchSalesman();
                                value.image = null;
                                passIdController.clear();
                                nameController.clear();
                              }
                            }
                          },
                          child: CustomContainer(
                            height: 60,
                            width: double.infinity,
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                            child: Center(
                              child: CustomText(
                                text: 'Submit',
                                fontSize: 20,
                                color: AppColors.secondaryColor,
                              ),
                            ),
                          ),
                        ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
