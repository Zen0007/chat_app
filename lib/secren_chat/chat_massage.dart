import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatMassage extends StatelessWidget {
  const ChatMassage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: dataChat(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('not have chat'),
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text('something went wrong'),
          );
        }

        final loadMassage = snapshot.data;
        return ListView.builder(
          itemCount: loadMassage!.length,
          itemBuilder: (context, index) =>
              Text("${snapshot.data![index]["text"]}"),
        );
      },
    );
  }
}

Stream<List<Map<String, dynamic>>>? dataChat() async* {
  try {
    final httpGet = Uri.parse(
        'https://chat-app-8122b-default-rtdb.asia-southeast1.firebasedatabase.app/chatUser.json');
    final response = await http.get(httpGet);

    /*below this variable for hold value Lifo*/
    final Queue<Map<String, dynamic>> descending =
        Queue<Map<String, dynamic>>();

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      for (var element in data.entries) {
        debugPrint(element.value["email"]);
        /*below this add like that stack */
        descending.addLast(
          {
            'text': element.value["text"],
            'createdTime': element.value["createdTime"],
            'userId': element.value["userId"],
            'userImage': element.value["userImage"],
            'userName': element.value["userName"],
          },
        );
      }
    }
    /*and below this code add map descending to list so list like a return descending */
    final List<Map<String, dynamic>> dataUser = [];
    for (var stack in descending) {
      dataUser.add(stack);
    }

    yield dataUser;

    debugPrint("${dataUser.first["id"]}  data form user");
  } catch (e, stackTrace) {
    debugPrint("$e");
    debugPrint("$stackTrace");
  }
}

class ChatMassageOne extends StatefulWidget {
  const ChatMassageOne({super.key});

  @override
  State<ChatMassageOne> createState() => _ChatMassageOneState();
}

class _ChatMassageOneState extends State<ChatMassageOne> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: dataChat(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Center(child: CircularProgressIndicator.adaptive()),
          );
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('not have chat'),
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text('something went wrong'),
          );
        }

        final loadMassage = snapshot.data;
        return ListView.builder(
          itemCount: loadMassage!.length,
          itemBuilder: (context, index) =>
              Text("${snapshot.data![index]["text"]}"),
        );
      },
    );
  }
}
