import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_assignment/controller/individual_screen_controller.dart';
import 'package:whatsapp_assignment/view/select_contact.dart';

import '../common/widgets/CustomCard.dart';
// import '../controller/mobile_layout_controller.dart';
// import '../model/chat_model.dart';

class ChatPage extends StatelessWidget {
  // final mobileLayoutController =
  //     Get.put(IndividualScreenController());
  ChatPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(SelectContact());
        },
        backgroundColor: const Color.fromRGBO(0, 167, 131, 1),
        child: const Icon(
          Icons.comment,
          color: Colors.white,
        ),
      ),
      body: GetX<IndividualScreenController>(
        init: IndividualScreenController(), // Ensure the controller is properly initialized.
        builder: (_) {
          if (_.chatContacts.isEmpty) {
            return Center(child: const CircularProgressIndicator()); // Show a loading indicator while data is loading.
          } else {
            return ListView.builder(
              itemCount: _.chatContacts.length,
              itemBuilder: (context, index) => CustomCard(
                chatModel: _.chatContacts[index],
              ),
            );
          }
        },
      ),
    );
  }
}
