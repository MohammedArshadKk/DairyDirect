// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:dairy_direct/model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderController extends ChangeNotifier {
  TextEditingController countController = TextEditingController();
  TextEditingController returnStockCountController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final SupabaseClient supabase = Supabase.instance.client;
  bool isLoading = false;
  bool isCompleted = false;
  List<OrderModel> histosy = [];
  double? longitude;
  double? latitude;
  OrderController() {
    countController.text = '0';
    returnStockCountController.text = '0';
  }
  increment() {
    countController.text = (int.parse(countController.text) + 1).toString();
    notifyListeners();
  }

  incrementReturn() {
    returnStockCountController.text =
        (int.parse(returnStockCountController.text) + 1).toString();
    notifyListeners();
  }

  decrement() {
    if (int.parse(countController.text) > 0) {
      countController.text = (int.parse(countController.text) - 1).toString();
      notifyListeners();
    }
  }

  decrementReturn() {
    if (int.parse(returnStockCountController.text) > 0) {
      returnStockCountController.text =
          (int.parse(returnStockCountController.text) - 1).toString();
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

  Future<void> historyOrder(String uid) async {
    try {
      isLoading = true;
      notifyListeners();
      final order =
          await supabase.from('order products').select().eq('uid', uid);
      histosy = order.map((data) {
        return OrderModel.fromMap(data);
      }).toList();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      log(e.toString());
    }
  }

  Future<void> getAllOrder() async {
    try {
      isLoading = true;
      notifyListeners();
      final order = await supabase
          .from('order products')
          .select()
          .eq('isInTransit', false);
      histosy = order.map((data) {
        return OrderModel.fromMap(data);
      }).toList();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      log(e.toString());
    }
  }

  getLongitudeLatitude(String uid) async {
    try {
      final data = await supabase
          .from('shop')
          .select('latitude, longitude')
          .eq('uid', uid)
          .limit(1);
      latitude = data[0]['latitude'];
      longitude = data[0]['longitude'];
      log(data.toString());
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  takeOrder(int id, int quantity, int productId) async {
    try {
      isLoading = true;
      notifyListeners();
      await supabase
          .from('order products')
          .update({'isInTransit': true}).eq("id", id);
      final data = await supabase
          .from('products')
          .select('quantity')
          .eq('id', productId)
          .limit(1);
      log(data.toString());
      int updatedQuantity = data[0]['quantity'] - quantity;
      await supabase
          .from('products')
          .update({'quantity': updatedQuantity}).eq("id", productId);
      notifyListeners();
      final currentPosition = await getCurrentLocation();

      if (currentPosition != null) {
        final url =
            'https://www.google.com/maps/dir/?api=1&destination=${latitude},${longitude}&origin=${currentPosition.latitude},${currentPosition.longitude}';

        if (await canLaunch(url)) {
          await launch(url);
          isLoading = false;
          notifyListeners();
        } else {
          isLoading = false;
          notifyListeners();
          throw 'Could not open Google Maps.';
        }
        isLoading = false;
        notifyListeners();
      }
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      log(e.toString());
    }
  }

  Future<Position?> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        log('Current location: ${position.latitude}, ${position.longitude}');
        return position;
      } else {
        log('Location permission denied.');
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<void> getIntransitOrder() async {
    try {
      isLoading = true;
      notifyListeners();
      final order = await supabase
          .from('order products')
          .select()
          .eq('isInTransit', true)
          .eq('isDelivered', false);
      histosy = order.map((data) {
        return OrderModel.fromMap(data);
      }).toList();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      log(e.toString());
    }
  }

  Future<void> viewLocation() async {
    isLoading = true;
    notifyListeners();
    final currentPosition = await getCurrentLocation();

    if (currentPosition != null) {
      final url =
          'https://www.google.com/maps/dir/?api=1&destination=${latitude},${longitude}&origin=${currentPosition.latitude},${currentPosition.longitude}';

      if (await canLaunch(url)) {
        await launch(url);
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
        throw 'Could not open Google Maps.';
      }
      isLoading = false;
      notifyListeners();
    }
    notifyListeners();
  }

  Future<void> isDeliveredFuction(
      int orderId, int productId, int quantity) async {
    try {
      await supabase
          .from('order products')
          .update({'isDelivered': true}).eq('id', orderId);
      final data = await supabase
          .from('products')
          .select('quantity')
          .eq('id', productId)
          .limit(1);
      log(data.toString());
      int updatedQuantity = data[0]['quantity'] + quantity;
      await supabase
          .from('products')
          .update({'quantity': updatedQuantity}).eq("id", productId);
      notifyListeners();
    } catch (e) {
      notifyListeners(); 
      log(e.toString());
    }
  }
}
