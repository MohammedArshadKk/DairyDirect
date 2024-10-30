
import 'package:dairy_direct/utils/colors.dart';
import 'package:dairy_direct/utils/images.dart';
import 'package:dairy_direct/view/screens/admin/admin_home.dart';
import 'package:dairy_direct/view/widgets/custom_container.dart';
import 'package:dairy_direct/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminLoginScreen extends StatelessWidget {
  AdminLoginScreen({super.key});
  final TextEditingController passIdController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final String passkey = dotenv.env['ADMIN_PASS_ID']!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.selectTypeImage),
            const CustomText(
              text: 'Enter Operation Unit Pass Id',
              fontSize: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: formKey,
                
                child: TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Enter pass id'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Operation Unit Pass Id';
                    } else if (passkey != value) {
                      return 'Invalid Operation Unit Pass Id';
                    }
                    return null;
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: GestureDetector(
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setBool('admin', true);
                    Get.offAll(() => AdminHomeScreen());
                  }
                },
                child: CustomContainer(
                  height: 60,
                  width: double.infinity,
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  child: Center(
                    child: CustomText(
                      text: 'Submit',
                      fontSize: 20,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
