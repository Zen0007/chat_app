import 'package:flutter/material.dart';
import 'package:flutter_app_chat/room_chat/chat.dart';
import 'package:flutter_app_chat/room_chat/message.dart';

class RoomChat extends StatefulWidget {
  const RoomChat({super.key, required this.ownRoom, required this.image});
  final String ownRoom;
  final String image;

  @override
  State<RoomChat> createState() => _RoomChatState();
}

class _RoomChatState extends State<RoomChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 75, 146, 252),
        automaticallyImplyLeading: false,
        titleSpacing: 0.0,
        title: Padding(
          padding: EdgeInsets.zero,
          child: Center(
            child: Row(
              spacing: 10,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back,
                  ),
                ),
                Image.asset(
                  widget.image,
                  width: 50,
                  height: 50,
                ),
                Text(
                  widget.ownRoom,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.cyan,
      body: Column(
        children: [
          Expanded(
            child: Chat(),
          ),
          Message()
        ],
      ),
    );
  }
}
