import 'package:dairy_direct/controller/order_controller.dart';
import 'package:dairy_direct/functions/show_message.dart';
import 'package:dairy_direct/model/order_model.dart';
import 'package:dairy_direct/utils/colors.dart';
import 'package:dairy_direct/view/widgets/custom_container.dart';
import 'package:dairy_direct/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

quantityAddDialog(BuildContext context, int quantity, String uid, int id) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Consumer<OrderController>(
          builder: (context, value, child) {
            return CustomContainer(
              height: 300,
              width: 400,
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(10),
              borderColor: Border.all(color: Colors.grey),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onLongPress: () {
                            value.decrement();
                            value.formKey.currentState!.validate();
                          },
                          child: CustomContainer(
                            height: 50,
                            width: 50,
                            color: AppColors.secondaryColor,
                            borderRadius: BorderRadius.circular(10),
                            borderColor: Border.all(color: Colors.blueGrey),
                            child: Center(
                              child: IconButton(
                                  onPressed: () {
                                    value.decrement();
                                    value.formKey.currentState!.validate();
                                  },
                                  icon: const Icon(
                                    Icons.remove,
                                    size: 30,
                                  )),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Form(
                            key: value.formKey,
                            child: Padding(
                              padding: const EdgeInsets.all(50.0),
                              child: Material(
                                elevation: 5,
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  controller: value.countController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder()),
                                  validator: (value) {
                                    int? count = int.parse(value!);
                                    if (count > quantity) {
                                      return 'out of stock';
                                    }
                                    if (count == 0) {
                                      return 'Please add quantity';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        CustomContainer(
                          height: 50,
                          width: 50,
                          color: AppColors.secondaryColor,
                          borderRadius: BorderRadius.circular(10),
                          borderColor: Border.all(color: Colors.blueGrey),
                          child: Center(
                            child: IconButton(
                                onPressed: () {
                                  value.increment();
                                  value.formKey.currentState!.validate();
                                },
                                icon: const Icon(
                                  Icons.add,
                                  size: 30,
                                )),
                          ),
                        ),
                      ],
                    ),
                    value.isLoading
                        ? const CircularProgressIndicator()
                        : GestureDetector(
                            onTap: () async {
                              if (value.formKey.currentState!.validate()) {
                                final OrderModel orderModel = OrderModel(
                                    uid: uid,
                                    productId: id,
                                    isInTransit: false,
                                    isDelivered: false,
                                    quantity:
                                        int.parse(value.countController.text));
                                await value.orderProducts(orderModel);
                                if (value.isCompleted) {
                                  Navigator.pop(context);
                                  showMessage('Order placed', context);
                                }
                              }
                            },
                            child: CustomContainer(
                              width: double.infinity,
                              height: 50,
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
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
