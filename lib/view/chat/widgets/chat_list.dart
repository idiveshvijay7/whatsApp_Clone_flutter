import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_assignment/controller/individual_screen_controller.dart';

import 'my_message_card.dart';
import 'sender_message_card.dart';

class chatList extends StatelessWidget {
  chatList({super.key, this.recieverUserId});
  final recieverUserId;
  final controller = Get.put(IndividualScreenController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        controller.scrollController
            .jumpTo(controller.scrollController.position.maxScrollExtent);
      });
      return ListView.builder(
          controller: controller.scrollController,
          itemCount: controller.chatMessages.length,
          itemBuilder: (context, index) {
            final messageData = controller.chatMessages[index];
            var timesent = DateFormat.Hm().format(messageData.timeSent);
            if (!messageData.isSeen &&
                messageData.recieverid ==
                    FirebaseAuth.instance.currentUser!.uid) {
              controller.setChatMessageSeen(
                messageData.messageId,
                recieverUserId
              );
            }
            if (messageData.senderId == FirebaseAuth.instance.currentUser) {
              return MyMessageCard(
                message: messageData.text,
                date: timesent,
                isSeen: messageData.isSeen,
              );
            }
            return SenderMessageCard(
              message: messageData.text,
              date: timesent,
            );
          });
    });
  }
}
