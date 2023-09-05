import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_assignment/model/user_model.dart';

// import '../view/mobile_layout_screen.dart';
// import 'package:whatsapp_assignment/vwiew/auth/otp_screen.dart';

class AuthController extends GetxController {
  final phoneController = TextEditingController();
  Country? country;

  final nameController = TextEditingController();
  File? image;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RxBool hasError = false.obs;

  @override
  void onInit() {
    super.onInit();
    // getCurrentUserData();
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }

  void pickCountry() {
    showCountryPicker(
      context: Get.context!, // Use Get.context to access the context.
      onSelect: (Country _country) {
        country = _country; // Update the Rx variable.
      },
    );
  }

  void storeUserData() {
    String name = nameController.text.trim();

    if (name.isNotEmpty) {
      saveUserDataToFirebase(name: name);
    }
  }

  void sendPhoneNumber() {
    String phoneNumber = phoneController.text.trim();
    if (country != null && phoneNumber.isNotEmpty) {
      signInWithPhone('+${country!.phoneCode}$phoneNumber');
    } else {
      // Show a snackbar or handle validation.
      Get.snackbar(
        'Fill Fields',
        'Please fill in all required fields.',
        snackPosition: SnackPosition.BOTTOM, // Adjust the position if needed
        backgroundColor:
            Colors.red, // Customize the snackbar's background color
        colorText: Colors.white, // Customize the text color
        borderRadius: 10, // Set the border radius
      );
    }
  }

  UserModel? currentUser;

  Future<void> getCurrentUserData() async {
    try {
      var userData = await _firestore
          .collection('users')
          .doc(_auth.currentUser?.uid)
          .get();

      if (userData.data() != null) {
        currentUser = UserModel.fromMap(userData.data()!);
        update(); // Notify listeners of the change
      }
    } catch (e) {
      hasError.value = true;
    }
  }

  Future<void> signInWithPhone(String phoneNumber) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar(
            'Authentication Failed',
            e.message!,
            snackPosition: SnackPosition.BOTTOM,
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          // Navigate to OTP screen and pass verificationId
          Get.offNamed('/otp', arguments: verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> verifyOTP(String verificationId, String otpCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpCode,
      );

      await _auth.signInWithCredential(credential);

      // Navigate to the next screen or perform any required actions on successful verification.
      Get.offNamed('/userPage'); // Replace '/home' with your desired route.
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> saveUserDataToFirebase({
    required String name,
  }) async {
    try {
      String uid = _auth.currentUser!.uid;
      String photoUrl =
          'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png';

      // if (profilePic != null) {
      //   photoUrl = await ref
      //       .read(commonFirebaseStorageRepositoryProvider)
      //       .storeFileToFirebase(
      //         'profilePic/$uid',
      //         profilePic,
      //       );
      // }

      var user = UserModel(
          name: name,
          uid: uid,
          profilePic: photoUrl,
          isOnline: true,
          phoneNumber: _auth.currentUser!.phoneNumber!);

      await _firestore.collection('users').doc(uid).set(user.toMap());
      Get.toNamed("/home");
      // Get.offAll("/home");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Stream<UserModel> userData(String userId) {
    return _firestore.collection('users').doc(userId).snapshots().map(
          (event) => UserModel.fromMap(
            event.data()!,
          ),
        );
  }

  // void setUserState(bool isOnline) async {
  //   await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
  //     'isOnline': isOnline,
  //   });
  // }
}
