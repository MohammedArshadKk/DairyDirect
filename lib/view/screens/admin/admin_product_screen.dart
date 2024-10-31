import 'package:dairy_direct/utils/colors.dart';
import 'package:flutter/material.dart';

class AdminProductScreen extends StatelessWidget {
  const AdminProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(onPressed: () {
        
      },child: const Icon(Icons.add),),
    );
  }
}