import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';

import '../../../common/color.dart';

class SenderMessageCard extends StatelessWidget {
  const SenderMessageCard({
    Key? key,
    required this.message,
    required this.date,
    // required this.type,
    // required this.username,
  }) : super(key: key);
  final String message;
  final String date;
  // final String type;
  // final VoidCallback onRightSwipe;
  // final String repliedText;
  // final String username;
  // final MessageEnum repliedMessageType;

  @override
  Widget build(BuildContext context) {
    // final isReplying = repliedText.isNotEmpty;

    return SwipeTo(
      onRightSwipe: () {},
      child: Align(
        alignment: Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 45,
          ),
          child: Card(
            elevation: 1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: senderMessageColor,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                          left: 10,
                          right: 30,
                          top: 5,
                          bottom: 20,
                        ),
                  child: Column(
                    children: [
                      // if (isReplying) ...[
                      //   Text(
                      //     username,
                      //     style: const TextStyle(
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      //   const SizedBox(height: 3),
                      //   Container(
                      //     padding: const EdgeInsets.all(10),
                      //     decoration: BoxDecoration(
                      //       color: backgroundColor.withOpacity(0.5),
                      //       borderRadius: const BorderRadius.all(
                      //         Radius.circular(
                      //           5,
                      //         ),
                      //       ),
                      //     ),
                      //     child: DisplayTextImageGIF(
                      //       message: repliedText,
                      //       type: repliedMessageType,
                      //     ),
                      //   ),
                      //   const SizedBox(height: 8),
                      // ],
                      Text(
                        message,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 2,
                  right: 10,
                  child: Text(
                    date,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}