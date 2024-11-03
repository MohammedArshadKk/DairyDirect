import 'dart:developer';

import 'package:dairy_direct/model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrderController extends ChangeNotifier {
  TextEditingController countController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final SupabaseClient supabase = Supabase.instance.client;
  bool isLoading = false;
  bool isCompleted = false;
  OrderController() {
    countController.text = '0';
  }
  increment() {
    countController.text = (int.parse(countController.text) + 1).toString();
    notifyListeners();
  }

  decrement() {
    if (int.parse(countController.text) > 0) {
      countController.text = (int.parse(countController.text) - 1).toString();
      notifyListeners();
    }
  }

  Future<void> orderProducts(OrderModel orderModel) async {
    try {
      isLoading = true;
      notifyListeners();
      await supabase.from('order products').insert(orderModel.toMap());
      isCompleted = true;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      log(e.toString());
      notifyListeners();
    }
  }
}
