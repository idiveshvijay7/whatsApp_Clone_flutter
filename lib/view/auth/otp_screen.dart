import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_assignment/controller/auth_controller.dart';

import '../../common/color.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key, required this.verificationId});

  final controller = Get.put(AuthController());
  final String verificationId;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verifying your number'),
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text('We have sent an SMS with a code.'),
            SizedBox(
              width: size.width * 0.5,
              child: TextField(
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: '- - - - - -',
                  hintStyle: TextStyle(
                    fontSize: 30,
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (val) {
                  if (val.length == 6) {
                    print('verifying otp');
                    controller.verifyOTP(
                        verificationId, val.trim()
                    );
                  }
                  print('This func is run');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
