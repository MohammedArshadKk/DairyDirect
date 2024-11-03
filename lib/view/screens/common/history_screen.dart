import 'package:dairy_direct/model/order_model.dart';
import 'package:dairy_direct/utils/colors.dart';
import 'package:dairy_direct/view/widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HistoryOrderScreen extends StatelessWidget {
  HistoryOrderScreen({super.key});
  final SupabaseClient supabase = Supabase.instance.client;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: StreamBuilder(
          stream: supabase
              .from('order products')
              .stream(primaryKey: ["id"])
              .eq("uid", _auth.currentUser!.uid)
              .order('created_at'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No Order'));
            }
            final orders =
                snapshot.data!.map((data) => OrderModel.fromMap(data)).toList();
            return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final OrderModel order = orders[index];
                  return Text(order.quantity.toString()); 
                });
          },
        ));
  }
}
