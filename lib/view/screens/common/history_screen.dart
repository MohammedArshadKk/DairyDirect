import 'package:dairy_direct/controller/order_controller.dart';
import 'package:dairy_direct/model/order_model.dart';
import 'package:dairy_direct/utils/colors.dart';
import 'package:dairy_direct/view/widgets/custom_container.dart';
import 'package:dairy_direct/view/widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HistoryOrderScreen extends StatefulWidget {
  const HistoryOrderScreen({super.key});

  @override
  State<HistoryOrderScreen> createState() => _HistoryOrderScreenState();
}

class _HistoryOrderScreenState extends State<HistoryOrderScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<OrderController>(context, listen: false)
          .historyOrder(_auth.currentUser!.uid);
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
                  text: 'Order History',
                  color: AppColors.secondaryColor,
                  fontSize: 24,
                )),
          ),
        ),
        body: ListView.builder(
          itemCount: orderHistory.histosy.length,
          itemBuilder: (context, index) {
            final OrderModel order = orderHistory.histosy[index];
            String formattedDate =
                DateFormat('yyyy-MM-dd HH:mm').format(order.createdAt!);

            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: CustomContainer(
                height: 200,
                width: double.infinity,
                borderRadius: BorderRadius.circular(8),
                borderColor:
                    Border.all(color: const Color.fromARGB(255, 213, 213, 213)),
                color: const Color(0xFFF2F4F7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.network(
                      order.imageUrl,
                      width: 150,
                      height: 200,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 35, left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: order.title,
                              fontSize: 20,
                              textAlign: TextAlign.start,
                              fontWeight: FontWeight.w600,
                            ),
                            CustomText(
                              text: formattedDate,
                              fontSize: 16,
                              textAlign: TextAlign.start,
                              color: const Color.fromARGB(255, 113, 112, 112),
                              fontWeight: FontWeight.w600,
                            ),
                            CustomText(
                              text: "Quantity : ${order.quantity}",
                              fontSize: 15,
                              textAlign: TextAlign.start,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                            ),
                            CustomText(
                              text: order.isDelivered
                                  ? "Delivered"
                                  : order.isInTransit
                                      ? 'In-Transit'
                                      : 'waiting for agent...',
                              fontSize: 14,
                              textAlign: TextAlign.start,
                              color: order.isDelivered
                                  ? Colors.green
                                  : order.isInTransit
                                      ? Colors.blue
                                      : Colors.red,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
