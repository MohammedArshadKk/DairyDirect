import 'dart:developer';

import 'package:dairy_direct/controller/add_salesman_controller.dart';
import 'package:dairy_direct/model/salesman_model.dart';
import 'package:dairy_direct/utils/alert.dart';
import 'package:dairy_direct/utils/colors.dart';
import 'package:dairy_direct/utils/loading_widget.dart';
import 'package:dairy_direct/view/screens/admin/add_salesman_screen.dart';
import 'package:dairy_direct/view/screens/admin/edit_salesman.dart';
import 'package:dairy_direct/view/widgets/custom_container.dart';
import 'package:dairy_direct/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SalesmanScreen extends StatefulWidget {
  const SalesmanScreen({super.key});

  @override
  State<SalesmanScreen> createState() => _SalesmanScreenState();
}

class _SalesmanScreenState extends State<SalesmanScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<AddSalesmanController>(context, listen: false)
          .fetchSalesman();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final salesman = Provider.of<AddSalesmanController>(context);

    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: AppColors.primaryColor,
        iconTheme: IconThemeData(color: AppColors.secondaryColor),
        title: Center(
          child: SizedBox(
            width: 150,
            child: CustomText(
              text: "Salesman",
              fontWeight: FontWeight.bold,
              color: AppColors.secondaryColor,
              fontSize: 25,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddSalesmanScreen());
        },
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Column(
        children: [
          CustomContainer(
            height: 50,
            width: double.infinity,
            color: AppColors.primaryColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          Expanded(
            child: salesman.isLoading
                ? const LoadingWidget()
                : ListView.builder(
                    itemCount: salesman.listOfSalesman.length,
                    itemBuilder: (context, index) {
                      final SalesmanModel man = salesman.listOfSalesman[index];
                      
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(10),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(man.imgUrl),
                              radius: 30,
                            ),
                            title: CustomText(
                              text: man.name,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: AppColors.primaryColor,
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Get.to(() =>
                                        EditSalesmanScreen(salesmanModel: man));
                                  },
                                  icon: const Icon(Icons.edit,
                                      color: Colors.blueAccent),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showMyDialog(
                                      context,
                                      () {
                                        salesman.delete(man.columId!);
                                      },
                                      'Do you want to delete the salesman?',
                                    );
                                  },
                                  icon: const Icon(Icons.delete,
                                      color: Colors.redAccent),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
