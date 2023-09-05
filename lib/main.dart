import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_assignment/common/color.dart';
import 'package:whatsapp_assignment/firebase_options.dart';
import 'package:whatsapp_assignment/landing_page.dart';
// import 'package:whatsapp_assignment/view/mobile_layout_screen.dart';
import 'package:whatsapp_assignment/common/Routes.dart';

import 'common/error.dart';
import 'controller/auth_controller.dart';
import 'view/mobile_layout_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final contoller = Get.put(AuthController());
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: backgroundColor,
          appBarTheme: const AppBarTheme(color: appBarColor)),
      getPages: getPage,
      // initialRoute: "/landing",
      // home: LandingScreen(),
      home: GetBuilder<AuthController>(initState: (_) {
        // Initialize user data in the AuthController
        contoller.getCurrentUserData();
      }, builder: (_) {
        final user = contoller.currentUser;
        // print(user);
        if (user != null) {
          return MobileLayoutScreen();
        } else if (_.hasError.value) {
          return ErrorScreen(
            error: 'Having some error in fetching the user',
          );
        } else {
          return LandingScreen();
        }
      }),
    );
  }
}
