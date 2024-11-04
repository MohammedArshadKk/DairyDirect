import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SalesmanLoginController extends ChangeNotifier {
  TextEditingController salesmanLoginIdController = TextEditingController();
  bool isLoading = false;
  bool isPassIdcurrect = false;
  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> salesmanLoginIdCheck() async {
    try {
      isLoading = true;
      notifyListeners();
      final pass = await supabase
          .from('salesman')
          .select()
          .eq('pass', salesmanLoginIdController.text)
          .limit(1);
      if (pass.isNotEmpty) {
        isPassIdcurrect = true;
        isLoading = false;
        notifyListeners();
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      log(e.toString());
    }
  }
}
