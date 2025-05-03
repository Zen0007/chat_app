import 'package:flutter/material.dart';
import 'package:flutter_app_chat/dummy_data/chat_data.dart';

class Message extends StatefulWidget {
  const Message({super.key, required this.contactName});
  final String contactName;
  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  final _massageController = TextEditingController();

  @override
  void dispose() {
    _massageController.dispose();
    super.dispose();
  }

  void addChat(String name, Map<String, String> chat) {
    setState(() {
      (contact["root"]!["contact"] as Map)[name].add(chat);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        bottom: 14,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(40)),
          color: const Color.fromARGB(255, 221, 217, 217),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 30),
                child: TextField(
                  controller: _massageController,
                  textCapitalization: TextCapitalization.sentences,
                  autocorrect: true,
                  enableSuggestions: true,
                  decoration:
                      const InputDecoration(labelText: "send a massage..."),
                ),
              ),
            ),
            IconButton(
              color: Colors.blue,
              onPressed: () => addChat(widget.contactName, {
                "message": _massageController.text,
                "date": "${DateTime.now()}"
              }),
              icon: const Icon(Icons.send),
            )
          ],
        ),
      ),
    );
  }
}
