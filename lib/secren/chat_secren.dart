import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_chat/secren/chat_massage.dart';
import 'package:flutter_app_chat/secren/massage.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('flutter Chat'),
        actions: [
          ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            child: const Text('Logout.'),
          )
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 89, 190, 237),
      body: const Column(
        children: [
          Expanded(
            child: ChatMassage(),
          ),
          MassageUser(),
        ],
      ),
    );
  }
}

/*
void _apiDatabase() {
  final apiUrl = Uri.https(
      'chat-app-8122b-default-rtdb.asia-southeast1.firebasedatabase.app',
      "users-data.json");
  http.post(
    apiUrl,
    headers: {"Content-Type": "application/json"},
    body: json.encode(
      {
        "data": 5,
      },
    ),
  );
}
*/
