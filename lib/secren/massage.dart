import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MassageUser extends StatefulWidget {
  const MassageUser({super.key});

  @override
  State<MassageUser> createState() => _MassageUserState();
}

class _MassageUserState extends State<MassageUser> {
  final _massageController = TextEditingController();

  @override
  void dispose() {
    _massageController.dispose();
    super.dispose();
  }

  void _sumbitMassage() async {
    try {
      final enterMassage = _massageController.text;
      if (enterMassage.trim().isEmpty) return;

      FocusScope.of(context).unfocus();

      final userId = FirebaseAuth.instance.currentUser!;

      /*  below this code for get data from realtime database firebase   */
      final getUserData = Uri.parse(
          'https://chat-app-8122b-default-rtdb.asia-southeast1.firebasedatabase.app/userData.json');
      var getData = await http.get(getUserData);

      /*  below for post data to real time database firebase      */
      final Map<String, dynamic> data = jsonDecode(getData.body);
      final forPostData = Uri.parse(
          'https://chat-app-8122b-default-rtdb.asia-southeast1.firebasedatabase.app/chatUser.json');

      /*  below this code for read data form database and store to Chat user    */
      final dateNow = DateTime.now().toString();
      for (var item in data.entries) {
        if (item.value["id"] == userId.uid) {
          http.post(
            forPostData,
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(
              {
                'text': enterMassage,
                'createdTime': dateNow,
                'userId': userId.uid,
                'userImage': item.value["userImage"],
                'userName': item.value["userName"],
              },
            ),
          );
        }
      }
      _massageController.clear();
    } catch (e, stackTrace) {
      debugPrint("$e");
      debugPrint("$stackTrace");
    }
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
          color: Colors.amber[400],
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
              onPressed: _sumbitMassage,
              icon: const Icon(Icons.send),
            )
          ],
        ),
      ),
    );
  }
}
