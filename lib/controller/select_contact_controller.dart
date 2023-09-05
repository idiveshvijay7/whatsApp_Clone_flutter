import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user_model.dart';

class SelectContactController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final RxList<Contact> contacts = <Contact>[].obs;
  final RxBool hasError = false.obs;
  @override
  void onInit() {
    super.onInit();
    // Load contacts when the controller is initialized
    loadContacts();
  }

  Future<void> loadContacts() async {
    try {
      if (await FlutterContacts.requestPermission()) {
        contacts
            .assignAll(await FlutterContacts.getContacts(withProperties: true));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void selectContact(Contact selectedContact) async {
    try {
      var userCollection = await firestore.collection('users').get();
      bool isFound = false;

      for (var document in userCollection.docs) {
        var userData = UserModel.fromMap(document.data());
        String selectedPhoneNum =
            selectedContact.phones[0].number.replaceAll(' ', '');
        if (selectedPhoneNum == userData.phoneNumber) {
          isFound = true;
          // Get.toNamed("/landing");
          Get.offNamed(
            "/individual",
            arguments: {
              'name' : userData.name,
              'uid' : userData.uid,
            },
          );
          break;
        }
      }

      if (!isFound) {
        Get.snackbar(
          '',
          'This number does not exist on this app.',
        );
      }
    } catch (e) {
      hasError.value = true;
      Get.snackbar('Error', e.toString());
    }
  }
}
