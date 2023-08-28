import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp_assignment/controller/auth_controller.dart';
import 'package:whatsapp_assignment/model/chat_contact.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'dart:io';

import '../model/message.dart';
import '../model/user_model.dart';

class IndividualScreenController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  final AuthController controller = Get.find();
  RxBool isShowSendButton = false.obs;
  final messageController = TextEditingController();
  final scrollController = ScrollController();
  // Observable list to store chat contacts
  var chatContacts = <ChatContact>[].obs;

  // Observable list to store chat messages
  var chatMessages = <Message>[].obs;

  // final chatContacts = RxList<ChatContact>([]);

  @override
  void onInit() {
    super.onInit();
    initChatContacts();
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }

  void initChatContacts() {
    firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .snapshots()
        .listen((event) async {
      List<ChatContact> contacts = [];
      for (var document in event.docs) {
        var chatContact = ChatContact.fromMap(document.data());
        var userData = await firestore
            .collection('users')
            .doc(chatContact.contactId)
            .get();
        var user = UserModel.fromMap(userData.data()!);

        contacts.add(
          ChatContact(
            name: user.name,
            profilePic: user.profilePic,
            contactId: chatContact.contactId,
            timeSent: chatContact.timeSent,
            lastMessage: chatContact.lastMessage,
          ),
        );
      }
      chatContacts.assignAll(contacts);
    });
  }

  void initChatMessages(String recieverUserId) {
    firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(recieverUserId)
        .collection('messages')
        .orderBy('timeSent')
        .snapshots()
        .listen((event) {
      List<Message> messages = [];
      for (var document in event.docs) {
        messages.add(Message.fromMap(document.data()));
      }
      chatMessages.assignAll(messages);
    });
  }

  void sendTextMessage({
    // String text = messageController.text.trim(),
    required String recieverUserId,
    // required MessageReply? messageReply,
  }) async {
    try {
      var senderUser = controller.currentUser!;
      String text = messageController.text.trim();
      var timeSent = DateTime.now();
      UserModel? recieverUserData;

      var userDataMap =
          await firestore.collection('users').doc(recieverUserId).get();
      recieverUserData = UserModel.fromMap(userDataMap.data()!);

      var messageId = const Uuid().v1();

      _saveDataToContactsSubcollection(
          senderUser, recieverUserData, text, timeSent, recieverUserId);

      _saveMessageToMessageSubcollection(
          recieverUserId: recieverUserId,
          text: text,
          timeSent: timeSent,
          messageType: text,
          messageId: messageId,
          username: senderUser.name,
          messageReply: text,
          recieverUserName: recieverUserData.name,
          senderUsername: senderUser.name);
    } catch (e) {
      Get.snackbar('Error',e.toString());
    }
  }

  void _saveDataToContactsSubcollection(
      UserModel senderUserData,
      UserModel? recieverUserData,
      String text,
      DateTime timeSent,
      String recieverUserId) async {
// users -> reciever user id => chats -> current user id -> set data
    var recieverChatContact = ChatContact(
      name: senderUserData.name,
      profilePic: senderUserData.profilePic,
      contactId: senderUserData.uid,
      timeSent: timeSent,
      lastMessage: text,
    );
    await firestore
        .collection('users')
        .doc(recieverUserId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .set(
          recieverChatContact.toMap(),
        );
    // users -> current user id  => chats -> reciever user id -> set data
    var senderChatContact = ChatContact(
      name: recieverUserData!.name,
      profilePic: recieverUserData.profilePic,
      contactId: recieverUserData.uid,
      timeSent: timeSent,
      lastMessage: text,
    );
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(recieverUserId)
        .set(
          senderChatContact.toMap(),
        );
  }

  void _saveMessageToMessageSubcollection(
      {required String recieverUserId,
      required String text,
      required DateTime timeSent,
      required String messageId,
      required String username,
      required String messageType,
      required String? messageReply,
      required String senderUsername,
      required String? recieverUserName}) async {
    final message = Message(
      senderId: auth.currentUser!.uid,
      recieverid: recieverUserId,
      text: text,
      sendMessagetype: text,
      timeSent: timeSent,
      messageId: messageId,
      isSeen: false,
      // repliedMessage: messageReply == null ? '' ,
      // repliedTo: messageReply == null
      //     ? ''
      //     : messageReply.isMe
      //         ? senderUsername
      //         : recieverUserName ?? '',
      // repliedMessageType:
      //     messageReply == null ? MessageEnum.text : messageReply.messageEnum, sendMessagetype: '',
    );
    // if (isGroupChat) {
    //   // groups -> group id -> chat -> message
    //   await firestore
    //       .collection('groups')
    //       .doc(recieverUserId)
    //       .collection('chats')
    //       .doc(messageId)
    //       .set(
    //         message.toMap(),
    //       );
    // } else {
    // users -> sender id -> reciever id -> messages -> message id -> store message
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(recieverUserId)
        .collection('messages')
        .doc(messageId)
        .set(
          message.toMap(),
        );
    // users -> eciever id  -> sender id -> messages -> message id -> store message
    await firestore
        .collection('users')
        .doc(recieverUserId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .collection('messages')
        .doc(messageId)
        .set(
          message.toMap(),
        );
    initChatMessages(recieverUserId);
    // }
  }

  void setChatMessageSeen(
    String recieverUserId,
    String messageId,
  ) async {
    try {
      await firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('chats')
          .doc(recieverUserId)
          .collection('messages')
          .doc(messageId)
          .update({'isSeen': true});

      await firestore
          .collection('users')
          .doc(recieverUserId)
          .collection('chats')
          .doc(auth.currentUser!.uid)
          .collection('messages')
          .doc(messageId)
          .update({'isSeen': true});
    } catch (e) {
      Get.snackbar('Error',e.toString());
    }
  }

  // Add other methods related to sending files, GIFs, and setting messages as seen
}
