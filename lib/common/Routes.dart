import 'package:get/get.dart';
import 'package:whatsapp_assignment/common/error.dart';
import 'package:whatsapp_assignment/landing_page.dart';
// import 'package:whatsapp_assignment/model/user_model.dart';
// import 'package:whatsapp_assignment/model/chat_model.dart';
import 'package:whatsapp_assignment/view/auth/login_screen.dart';
import 'package:whatsapp_assignment/view/auth/otp_screen.dart';
import 'package:whatsapp_assignment/view/auth/user_infomation_screen.dart';
import 'package:whatsapp_assignment/view/chat/individual_screen.dart';
import 'package:whatsapp_assignment/view/mobile_layout_screen.dart';

List<GetPage<dynamic>> getPage = [
  GetPage(name: "/landing", page: () => LandingScreen()),
  GetPage(name: "/login", page: () => LoginScreen()),
  GetPage(name: "/home", page: () => MobileLayoutScreen()),
  GetPage(
      name: "/error", page: () => const ErrorScreen(error: 'Page Not Found')),
  GetPage(
      name: "/otp",
      page: () {
        final verificationId = Get.arguments as String;
        return OtpScreen(verificationId: verificationId);
      }),
  GetPage(name: "/userPage", page: () => UserInformationScreen()),
  GetPage(
      name: "/individual",
      page: () {
        final name = Get.arguments as String;
        final uid = Get.arguments as String;
        return IndividualScreen(
          name: name,
          uid: uid,
        );
      })
];
