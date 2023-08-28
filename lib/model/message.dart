class Message {
  final String senderId;
  final String recieverid;
  final String text;
  final String sendMessagetype;
  final DateTime timeSent;
  final String messageId;
  final bool isSeen;

  Message({
    required this.senderId,
    required this.recieverid,
    required this.text,
    required this.sendMessagetype,
    required this.timeSent,
    required this.messageId,
    required this.isSeen
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'recieverid': recieverid,
      'text': text,
      'type': sendMessagetype,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'messageId': messageId,
      'isSeen': isSeen,
      // 'repliedMessage': repliedMessage,
      // 'repliedTo': repliedTo,
      // 'repliedMessageType': repliedMessageType,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['senderId'] ?? '',
      recieverid: map['recieverid'] ?? '',
      text: map['text'] ?? '',
      sendMessagetype: map['type'] ?? '',
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
      messageId: map['messageId'] ?? '',
      isSeen: map['isSeen'] ?? false,
      // repliedMessage: map['repliedMessage'] ?? '',
      // repliedTo: map['repliedTo'] ?? '',
      // repliedMessageType: map['repliedMessageType'] ?? '',
    );
  }
}