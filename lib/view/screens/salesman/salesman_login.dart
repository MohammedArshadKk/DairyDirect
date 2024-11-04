import 'package:dairy_direct/controller/salesman_login_controller.dart';
import 'package:dairy_direct/functions/show_message.dart';
import 'package:dairy_direct/utils/colors.dart';
import 'package:dairy_direct/utils/images.dart';
import 'package:dairy_direct/view/screens/admin/admin_home.dart';
import 'package:dairy_direct/view/widgets/custom_container.dart';
import 'package:dairy_direct/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SalesmanLogin extends StatelessWidget {
  SalesmanLogin({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: SingleChildScrollView(
        child: Consumer<SalesmanLoginController>(
          builder: (context, value, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppImages.selectTypeImage),
                const CustomText(
                  text: 'Enter Your Pass Id',
                  fontSize: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Form(
                    key: formKey,
                    child: TextFormField(
                      controller: value.salesmanLoginIdController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter pass id'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter Operation Unit Pass Id';
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
                        await value.salesmanLoginIdCheck();
                        if (value.isPassIdcurrect) {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setBool('salesman', true);
                        } else {
                          showMessage('password incorrect', context);
                        }

                        // Get.offAll(() => AdminHomeScreen());
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
            );
          },
        ),
      ),
    );
  }
}
