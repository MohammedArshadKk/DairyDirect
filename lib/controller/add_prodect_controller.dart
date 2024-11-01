import 'dart:developer';
import 'dart:io';

import 'package:dairy_direct/model/prodect_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddProdectController extends ChangeNotifier {
  File? image;
  final ImagePicker picker = ImagePicker();
  bool isLoading = false;
  String? productImageUrl;
  final SupabaseClient supabase = Supabase.instance.client;
  bool iscompleted = false;
  List<ProductModel> products = [];
  Future<void> pickProductImage() async {
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

  Future<void> uploadProductImage() async {
    try {
      isLoading = true;
      notifyListeners();
      final String filePath = 'product${DateTime.now().millisecondsSinceEpoch}';
      await supabase.storage.from('products').upload(filePath, image!);
      productImageUrl =
          supabase.storage.from('products').getPublicUrl(filePath);
      log(productImageUrl.toString());
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      log(e.toString());
    }
  }

  Future<void> addProductToTable(ProductModel prodectModel) async {
    try {
      isLoading = true;
      notifyListeners();
      await supabase.from('products').insert(prodectModel.toMap());
      isLoading = false;
      iscompleted = true;
      image = null;
      productImageUrl = null;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      log(e.toString());
    }
  }

  Future<void> getAllProduct() async {
    try {
      isLoading = true;
      notifyListeners();
      final data = await supabase.from('products').select();
      products = data.map((product) {
        return ProductModel.fromMap(product);
      }).toList();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      log(e.toString());
    }
  }

  deleteProduct(int id) async {
    try {
      await supabase.from('products').delete().eq('id', id);
      getAllProduct();
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> editProduct(ProductModel prodectModel, int id) async {
    try {
      isLoading = true;
      notifyListeners();
      await supabase.from('products').update(prodectModel.toMap()).eq("id", id);
      isLoading = false;
      iscompleted = true;
      image = null;
      productImageUrl = null;
      getAllProduct();
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      log(e.toString());
    }
  }
}
