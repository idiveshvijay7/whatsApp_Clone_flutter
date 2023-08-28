import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_assignment/common/color.dart';
import 'package:whatsapp_assignment/controller/individual_screen_controller.dart';

class BottomChatField extends StatelessWidget {
  final controller = Get.put(IndividualScreenController());
  BottomChatField({super.key, this.recieverUserId});
  final recieverUserId;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // isShowMessageReply ? const MessageReplyPreview() : const SizedBox(),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                // focusNode: focusNode,
                controller: controller.messageController,
                onChanged: (val) {
                  if (val.isNotEmpty) {
                    controller.isShowSendButton.value = true;
                  } else {
                    controller.isShowSendButton.value = false;
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: mobileChatBoxColor,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.emoji_emotions,
                              color: Colors.grey,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.gif,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  suffixIcon: SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Colors.grey,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.attach_file,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  hintText: 'Type a message!',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(10),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 8,
                right: 2,
                left: 2,
              ),
              child: CircleAvatar(
                backgroundColor: const Color(0xFF128C7E),
                radius: 25,
                child: GestureDetector(
                    child: Obx(() => Icon(
                          controller.isShowSendButton.value
                              ? Icons.send
                              : Icons.mic,
                          color: Colors.white,
                        )),
                    onTap: () {
                      controller.sendTextMessage(
                          recieverUserId: recieverUserId);
                    }),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 310,
          child: EmojiPicker(
            onEmojiSelected: ((category, emoji) {}),
          ),
        )
        // : const SizedBox(),
      ],
    );
  }
}
