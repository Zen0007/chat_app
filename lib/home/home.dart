import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_chat/home/contact.dart';
import 'package:flutter_app_chat/servis/router/add_contact.dart';
import 'package:flutter_app_chat/servis/router/get_contact.dart';
import 'package:hive/hive.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<StatefulWidget> createState() => _Home();
}

class _Home extends State<Home> {
  TextEditingController textEditController = TextEditingController();
  //static final scaffoldKey = GlobalKey<ScaffoldState>();
  final contact = GetContact();
  final addContact = AddContact();

  @override
  void initState() {
    super.initState();
    contact.connect();
    addContact.connect();
  }

  @override
  void dispose() {
    contact.close();
    addContact.close();
    textEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.elliptical(50, 10),
                  bottomRight: Radius.elliptical(50, 10),
                ),
                color: Colors.white54,
              ),
              width: size.width * 0.5,
              height: size.height * 0.5,
              child: Row(
                children: [
                  Center(
                    child: IconButton(
                      onPressed: () {
                        //=> scaffoldKey.currentState!.openDrawer(),
                        showCustomDialog(context);
                      },
                      icon: const Icon(Icons.menu),
                    ),
                  ),
                  const Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        "CHAT",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.blueAccent[100],
      body: Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 20),
        child: contact.channel == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : StreamBuilder(
                stream: contact.channel!.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = jsonDecode(snapshot.data);
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Contact(
                          name: data[index]["friendName"],
                          image: "assets/images/graph.png",
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                },
              ),
      ),
    );
  }

  void showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          titlePadding: EdgeInsets.zero, // supaya title bisa kita custom
          title: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("New Contact"),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
          content: TextField(
            controller: textEditController,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              labelText: 'ID',
              labelStyle: TextStyle(
                color: Color(0xFF6200EE),
              ),
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _sumbit();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _sumbit() async {
    final box = await Hive.openBox("auth");
    final user = box.get("profile");
    print("$user ----------");
    if (user == null) {
      return;
    }
    if (textEditController.text.isNotEmpty) {
      addContact.sendMessage(
        jsonEncode(
          {
            "userId": user["userId"],
            "contactId": textEditController.text,
          },
        ),
      );
    }
    print(user["userId"]);
    print(textEditController.text);
  }
}
