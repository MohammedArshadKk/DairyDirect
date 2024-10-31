import 'dart:developer';

import 'package:dairy_direct/controller/add_salesman_controller.dart';
import 'package:dairy_direct/functions/encrypt.dart';
import 'package:dairy_direct/functions/show_message.dart';
import 'package:dairy_direct/model/salesman_model.dart';
import 'package:dairy_direct/utils/colors.dart';
import 'package:dairy_direct/view/widgets/custom_container.dart';
import 'package:dairy_direct/view/widgets/custom_text.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class EditSalesmanScreen extends StatefulWidget {
  EditSalesmanScreen({super.key, required this.salesmanModel});
  final SalesmanModel salesmanModel;

  @override
  State<EditSalesmanScreen> createState() => _EditSalesmanScreenState();
}

class _EditSalesmanScreenState extends State<EditSalesmanScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController passIdController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final EncryptData encryptData = EncryptData();
  @override
  void initState() {
    nameController.text = widget.salesmanModel.name;
    passIdController.text = widget.salesmanModel.pass;
    super.initState();
  }

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
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Image.network(
                                        widget.salesmanModel.imgUrl,
                                        width: 180,
                                        height: 180,
                                        fit: BoxFit.cover,
                                      ),
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
                            if (formKey.currentState!.validate()) {
                              if (value.image != null) {
                                await value.uploadProfile();
                              }

                              SalesmanModel salesmanModel = SalesmanModel(
                                  name: nameController.text,
                                  pass: passIdController.text,
                                  imgUrl: value.image == null
                                      ? widget.salesmanModel.imgUrl
                                      : value.profile!);
                              await value.edit(
                                  salesmanModel: salesmanModel,
                                  id: widget.salesmanModel.columId!);
                              if (value.iscompleted) {
                                showMessage("Salesman edited", context);
                              }
                              value.fetchSalesman();
                              value.image = null;
                              passIdController.clear();
                              nameController.clear();
                              Navigator.pop(context);
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
