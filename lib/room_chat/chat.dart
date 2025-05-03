import 'package:flutter/material.dart';
import 'package:flutter_app_chat/dummy_data/chat_data.dart';


class Chat extends StatefulWidget {
  const Chat({super.key,required this.memberChat});
  final String memberChat;

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
 @override
  Widget build(BuildContext context) {
    final data = getChat(widget.memberChat);
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 40),
      reverse: true,
      itemCount: data.length,
      itemBuilder: (context, index) {
        print("data $data");
        return Text("${data[index]["message"]}");
      },
    );
  }
}