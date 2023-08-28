import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:whatsapp_assignment/controller/individual_screen_controller.dart';
// import 'package:whatsapp_assignment/model/user_model.dart';
import 'package:whatsapp_assignment/view/chat/widgets/chat_list.dart';
// import 'package:whatsapp_assignment/view/chat_page.dart';

import '../../common/color.dart';
import 'widgets/bottom_chat_field.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// import '../model/chat_model.dart';
// import '../model/message_model.dart';

class IndividualScreen extends StatelessWidget {
  IndividualScreen({Key? key, required this.name, required this.uid}) : super(key: key);
  final String name;
  final String uid;
  // final ChatModel sourchat;
  final controller = Get.put(IndividualScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text(name),
            // : StreamBuilder<UserModel>(
            //     stream: ref.read(authControllerProvider).userDataById(uid),
            //     builder: (context, snapshot) {
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return const Loader();
            //       }
            //       return Column(
            //         children: [
            //           Text(name),
            //           Text(
            //             snapshot.data!.isOnline ? 'online' : 'offline',
            //             style: const TextStyle(
            //               fontSize: 13,
            //               fontWeight: FontWeight.normal,
            //             ),
            //           ),
            //         ],
            //       );
            //     }),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: chatList(
              recieverUserId: uid
            ),
          ),
          BottomChatField(
            recieverUserId: uid
          ),
        ],
      ),
    );
  }
}
