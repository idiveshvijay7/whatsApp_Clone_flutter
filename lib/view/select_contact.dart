import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_assignment/controller/select_contact_controller.dart';

// import '../common/widgets/ButtonCard.dart';
// import '../common/widgets/ContactCard.dart';
// import '../model/chat_model.dart';

class SelectContact extends StatelessWidget {
  SelectContact({super.key});
  final controller = Get.put(SelectContactController());

  @override
  Widget build(BuildContext context) {
    // List<ChatModel> contacts = [
    //   ChatModel(name: "Dev Stack", status: "A full stack developer"),
    //   ChatModel(name: "Balram", status: "Flutter Developer..........."),
    //   ChatModel(name: "Saket", status: "Web developer..."),
    //   ChatModel(name: "Bhanu Dev", status: "App developer...."),
    //   ChatModel(name: "Collins", status: "Raect developer.."),
    //   ChatModel(name: "Kishor", status: "Full Stack Web"),
    //   ChatModel(name: "Testing1", status: "Example work"),
    //   ChatModel(name: "Testing2", status: "Sharing is caring"),
    //   ChatModel(name: "Divyanshu", status: "....."),
    //   ChatModel(name: "Helper", status: "Love you Mom Dad"),
    //   ChatModel(name: "Tester", status: "I find the bugs"),
    // ];

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF075E54),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select Contact",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Obx(() => Text(
                    controller.contacts.length.toString(),
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ))
            ],
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.search,
                  size: 26,
                ),
                onPressed: () {}),
            PopupMenuButton<String>(
              padding: EdgeInsets.all(0),
              onSelected: (value) {
                print(value);
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    child: Text("Invite a friend"),
                    value: "Invite a friend",
                  ),
                  PopupMenuItem(
                    child: Text("Contacts"),
                    value: "Contacts",
                  ),
                  PopupMenuItem(
                    child: Text("Refresh"),
                    value: "Refresh",
                  ),
                  PopupMenuItem(
                    child: Text("Help"),
                    value: "Help",
                  ),
                ];
              },
            ),
          ],
        ),
        body: Obx(() => ListView.builder(
            itemCount: controller.contacts.length + 2,
            itemBuilder: (context, index) {
              final contact = controller.contacts[index];
              return InkWell(
                onTap: () => controller.selectContact(contact),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ListTile(
                    title: Text(
                      contact.displayName,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    leading: contact.photo == null
                        ? null
                        : CircleAvatar(
                            backgroundImage: MemoryImage(contact.photo!),
                            radius: 30,
                          ),
                  ),
                ),
              );
            })));
  }
}
