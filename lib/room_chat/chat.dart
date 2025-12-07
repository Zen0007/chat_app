import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({super.key, required this.memberChat});
  final String memberChat;

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> data = [];
    for (var i = 0; i <= 20; i++) {
      if (i % 2 == 0) {
        data.add(
          {
            "message":
                "you too $i 555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555",
            "date": "${DateTime.now()}",
            "isMe": false,
            "userName": "yuno"
          },
        );
        data.add(
          {
            "message":
                "you too  $i 2222222222222222222222222222223333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333332222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222",
            "date": "${DateTime.now()}",
            "isMe": true,
            "userName": "yuno"
          },
        );
      }
    }
    return ListView.builder(
      padding: EdgeInsets.only(top: 30, bottom: 20),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final chat = data[index];

        return Align(
          alignment:
              chat["isMe"] ? Alignment.centerRight : Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: chat["isMe"]
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color:
                      chat["isMe"] ? Colors.amberAccent[200] : Colors.grey[400],
                  borderRadius: BorderRadius.only(
                    topLeft: chat["isMe"]
                        ? const Radius.elliptical(12, 12)
                        : Radius.zero,
                    topRight: !chat["isMe"]
                        ? const Radius.elliptical(12, 12)
                        : Radius.zero,
                    bottomLeft: const Radius.elliptical(12, 12),
                    bottomRight: const Radius.elliptical(12, 12),
                  ),
                ),
                constraints: const BoxConstraints(maxWidth: 440),
                padding: const EdgeInsets.symmetric(
                  vertical: 11,
                  horizontal: 14,
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: 17,
                ),
                child: Text(
                  chat["message"],
                  style: TextStyle(
                    height: 1.3,
                    fontSize: 16.5,
                    color: Colors.black,
                  ),
                  softWrap: true,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 25,
                  right: 25,
                  bottom: 15,
                  top: 5,
                ),
                child: Text(
                  (chat["date"] as String).substring(10, 16),
                  style: TextStyle(
                    fontSize: 13.5,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
