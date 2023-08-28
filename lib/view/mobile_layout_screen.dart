import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get.dart';
import 'package:whatsapp_assignment/common/color.dart';
// import 'package:whatsapp_assignment/controller/mobile_layout_controller.dart';
import 'package:whatsapp_assignment/view/chat_page.dart';
// import 'package:whatsapp_assignment/controller/mobile_layout_controller.dart';

class MobileLayoutScreen extends StatelessWidget {
  
  MobileLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFF075E54),
          centerTitle: false,
          title: const Text(
            'WhatsApp Clone',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white70,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white70),
              onPressed: () {},
            ),
            PopupMenuButton<String>(
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white70,
              ),
              onSelected: (Value){
                print(Value);
              },
              itemBuilder: (context) {
                // Define the items in the popup menu.
                return [
                  const PopupMenuItem(
                    value: 'Settings',
                    child: Text('Settings'),
                  ),
                ];
              },
            ),
          ],
          bottom: const TabBar(
            // controller: mobileLayoutController._tabController,
            indicatorColor: tabColor,
            indicatorWeight: 4,
            labelColor: tabColor,
            unselectedLabelColor: Colors.white70,
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            tabs: [
              Tab(
                text: 'CHATS',
              ),
              Tab(
                text: 'STATUS',
              ),
              Tab(
                text: 'CALLS',
              ),
            ],
          ),
        ),
        body: TabBarView(
          // controller: tabBarController,
          children: [
            ChatPage(),
            // StatusContactsScreen(),
            Text('Status'),
            Text('calls')
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {},
        //   backgroundColor: const Color.fromRGBO(0, 167, 131, 1),
        //   child: const Icon(
        //     Icons.comment,
        //     color: Colors.white,
        //   ),
        // ),
      ),
    );
  }
}
