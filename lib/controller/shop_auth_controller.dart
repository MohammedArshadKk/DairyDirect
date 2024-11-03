import 'dart:developer';
import 'dart:io';

import 'package:dairy_direct/model/shop_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ShopAuthController extends ChangeNotifier {
  File? image;
  final ImagePicker picker = ImagePicker();
  bool isLoading = false;
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  firebase_auth.User? user;
  final SupabaseClient supabase = Supabase.instance.client;
  String? shopImageUrl;
  bool isCompleated = false;
  bool isShopExist = false;

  Future<void> pickShopImage() async {
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

  signInWithGoogle() async {
    try {
      await googleSignIn.signOut();
      isLoading = true;
      notifyListeners();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final firebase_auth.AuthCredential credential =
            firebase_auth.GoogleAuthProvider.credential(
                accessToken: googleSignInAuthentication.accessToken,
                idToken: googleSignInAuthentication.idToken);
        final userCredential = await _auth.signInWithCredential(credential);
        log(userCredential.user!.email.toString());
        log(userCredential.user!.displayName.toString());
        user = userCredential.user;
        isLoading = false;
        isCompleated = true;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      log(e.toString());
    }
  }

  Future<void> uploadShopImg() async {
    try {
      isLoading = true;
      notifyListeners();
      final String filePath = DateTime.now().microsecondsSinceEpoch.toString();
      final response =
          await supabase.storage.from('shopImage').upload(filePath, image!);

      final imageUrl =
          await supabase.storage.from('shopImage').getPublicUrl(filePath);
      shopImageUrl = imageUrl;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      log(e.toString());
    }
  }

  Future<void> shopAddToTable({required ShopModel shopModel}) async {
    try {
      isLoading = true;
      notifyListeners();
      await supabase.from('shop').insert(shopModel.toMap());
      isLoading = false;
      image = null;
      shopImageUrl = null;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      log(e.toString());

      notifyListeners();
    }
  }

  Future<void> checkShopExist(String uid) async {
    try {
      isLoading = true;
      notifyListeners();
      final data = await supabase.from('shop').select().eq('uid', uid).limit(1);
      log(data.isNotEmpty.toString());
      if (data.isNotEmpty) {
        isShopExist = true;
      } else {
        isShopExist = false;
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
