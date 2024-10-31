import 'dart:developer';
import 'dart:io';

import 'package:dairy_direct/functions/encrypt.dart';
import 'package:dairy_direct/model/salesman_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddSalesmanController extends ChangeNotifier {
  File? image;
  final ImagePicker picker = ImagePicker();
  final SupabaseClient supabase = Supabase.instance.client;
  final en = EncryptData();
  bool iscompleted = false;
  String? profile;
  bool isLoading = false;
  List<SalesmanModel> listOfSalesman = [];
  Future<void> pickProfile() async {
    try {
      final pickIcon = await picker.pickImage(source: ImageSource.gallery);
      if (pickIcon != null) {
        image = File(pickIcon.path);
        log(image!.path);
        notifyListeners();
      } else {
        log('is null');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> uploadProfile() async {
    try {
      isLoading = true;
      notifyListeners();
      final String filePath = DateTime.now().microsecondsSinceEpoch.toString();
      final response = await supabase.storage
          .from('salesman profile')
          .upload(filePath, image!);

      final imageUrl = await supabase.storage
          .from('salesman profile')
          .getPublicUrl(filePath);
      profile = imageUrl;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      log(e.toString());
    }
  }

  Future<void> addToTable({required SalesmanModel salesman}) async {
    try {
      isLoading = true;
      notifyListeners();
      await supabase.from('salesman').insert(salesman.toMap());
      isLoading = false;
      iscompleted = true;
      image = null;
      profile = null;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      log(e.toString());

      notifyListeners();
    }
  }

  Future<void> fetchSalesman() async {
    try {
      isLoading = true;
      notifyListeners();
      final data = await supabase.from('salesman').select();
      listOfSalesman = data.map((e) {
        return SalesmanModel.fromMap(e);
      }).toList();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      log(e.toString());
    }
  }

  Future<void> delete(int id) async {
    try {
      await supabase.from('salesman').delete().eq("id", id);
      fetchSalesman();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> edit(
      {required SalesmanModel salesmanModel, required int id}) async {
    log(id.toString());
    try {
      isLoading = true;
      notifyListeners();
      await supabase
          .from('salesman')
          .update(salesmanModel.toMap())
          .eq('id', id);
      await fetchSalesman();
      isLoading = false;
      iscompleted=true;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      log(e.toString());
    }
  }
}
