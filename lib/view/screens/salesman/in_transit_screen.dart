import 'package:dairy_direct/controller/order_controller.dart';
import 'package:dairy_direct/model/order_model.dart';
import 'package:dairy_direct/utils/alert.dart';
import 'package:dairy_direct/utils/colors.dart';
import 'package:dairy_direct/view/screens/common/select_user_type.dart';
import 'package:dairy_direct/view/widgets/custom_container.dart';
import 'package:dairy_direct/view/widgets/custom_text.dart';
import 'package:dairy_direct/view/widgets/return_stock.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntransitScreen extends StatefulWidget {
  const IntransitScreen({super.key});

  @override
  State<IntransitScreen> createState() => _IntransitScreenState();
}

class _IntransitScreenState extends State<IntransitScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<OrderController>(context, listen: false).getIntransitOrder();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderHistory = Provider.of<OrderController>(context);
    return Scaffold(
        backgroundColor: AppColors.secondaryColor,
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          // toolbarHeight: 100,
          iconTheme: IconThemeData(color: AppColors.secondaryColor),
          title: Center(
            child: SizedBox(
                width: 200,
                child: CustomText(
                  text: 'In-transit Orders',
                  color: AppColors.secondaryColor,
                  fontSize: 24,
                )),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                showMyDialog(context, () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setBool('salesman', false);
                  Get.offAll(() => const SelectUserTypeScreen());
                }, '"Are you sure you want to logout?"');
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body:orderHistory.histosy.isEmpty ? Center(child: CustomText(text: 'No Data', ),):
         ListView.builder(
          itemCount: orderHistory.histosy.length,
          itemBuilder: (context, index) {
            final OrderModel order = orderHistory.histosy[index];
            String formattedDate =
                DateFormat('yyyy-MM-dd HH:mm').format(order.createdAt!);

            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: CustomContainer(
                height: 160,
                width: double.infinity,
                borderRadius: BorderRadius.circular(8),
                borderColor:
                    Border.all(color: const Color.fromARGB(255, 213, 213, 213)),
                color: const Color(0xFFF2F4F7),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.network(
                          order.imageUrl,
                          width: 80,
                          height: 80,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20, left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: order.title,
                                  fontSize: 15,
                                  textAlign: TextAlign.start,
                                  fontWeight: FontWeight.w600,
                                ),
                                CustomText(
                                  text: formattedDate,
                                  fontSize: 13,
                                  textAlign: TextAlign.start,
                                  color:
                                      const Color.fromARGB(255, 113, 112, 112),
                                  fontWeight: FontWeight.w600,
                                ),
                                CustomText(
                                  text: "Quantity : ${order.quantity}",
                                  fontSize: 12,
                                  textAlign: TextAlign.start,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 8,
                          ),
                          child: orderHistory.isLoading
                              ? const CircularProgressIndicator()
                              : GestureDetector(
                                  onTap: () async {
                                    returnStockAddDialog(
                                        context, order.productId, order.id!);
                                    Provider.of<OrderController>(context,
                                            listen: false)
                                        .getIntransitOrder();
                                  },
                                  child: CustomContainer(
                                    height: 40,
                                    width: 100,
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(8),
                                    child: Center(
                                      child: CustomText(
                                        text: 'Delivered',
                                        color: AppColors.secondaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 8,
                          ),
                          child: GestureDetector(
                            onTap: () async {
                              await orderHistory.viewLocation();
                            },
                            child: CustomContainer(
                              height: 40,
                              width: 100,
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(8),
                              child: Center(
                                child: CustomText(
                                  text: 'view location',
                                  color: AppColors.secondaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
