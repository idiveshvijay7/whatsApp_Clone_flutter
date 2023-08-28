import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_assignment/controller/auth_controller.dart';

import '../../common/color.dart';
import '../../common/widgets/CustomButton.dart';

class LoginScreen extends StatelessWidget {
  final controller = Get.put(AuthController());
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter your phone number'),
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('WhatsApp will need to verify your phone number.'),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  controller.pickCountry();
                },
                child: const Text('Pick Country'),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  if (controller.country != null)
                    GetBuilder<AuthController>(
                      init: AuthController(),
                      initState: (_) {},
                      builder: (_) {
                        return Text('+${controller.country!.phoneCode}');
                      },
                    ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: size.width * 0.7,
                    child: TextField(
                      controller: controller.phoneController,
                      decoration: const InputDecoration(
                        hintText: 'phone number',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.6),
              SizedBox(
                width: 90,
                child: CustomButton(
                  onPressed: () {
                    controller.sendPhoneNumber();
                    // Get.offAll('/userPage'); // Replace '/home' with your desired route.
                  },
                  text: 'NEXT',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
