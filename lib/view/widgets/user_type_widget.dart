import 'package:dairy_direct/utils/colors.dart';
import 'package:dairy_direct/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class UserTypeWidget extends StatelessWidget {
  const UserTypeWidget({super.key, required this.text, required this.icon});
 final String text;
 final IconData icon;    
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        color: AppColors.primaryColor,
        child: SizedBox(
          height: 70,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: ListTile(
              leading: Icon(
                icon,
                size: 25,
                color: AppColors.secondaryColor,
              ),
              title: CustomText(
                text: text,
                fontSize: 20,
                color: AppColors.secondaryColor,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: AppColors.secondaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
