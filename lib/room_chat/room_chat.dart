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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Padding(
          padding: EdgeInsets.zero,
          child: Container(
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.only(
              //   bottomLeft: Radius.elliptical(50, 10),
              //   bottomRight: Radius.elliptical(50, 10),
              // ),
              color: Colors.white38,
            ),
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
      backgroundColor: Colors.blueAccent[100],
      body: Column(
        children: [
          Expanded(
            child: Chat(
              memberChat: widget.ownRoom,
            ),
          ),
          Message(
            contactName: widget.ownRoom,
          )
        ],
      ),
    );
  }
}
