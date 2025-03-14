import 'package:flutter/material.dart';
import 'package:flutter_app_chat/home/contact.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  static final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.blueAccent,
              ),
              width: size.width * 0.5,
              height: size.height * 0.5,
              child: Row(
                children: [
                  Center(
                    child: IconButton(
                      onPressed: () => scaffoldKey.currentState!.openDrawer(),
                      icon: const Icon(Icons.menu),
                    ),
                  ),
                  const Expanded(
                    flex: 2,
                    child: Center(
                      child: Text("CHAT"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      drawer: drawer(),
      backgroundColor: Colors.blueAccent[100],
      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Contact(
              name: data[index]['name'],
              text: data[index]["text"],
              dataTime: data[index]["dateTime"],
            );
          },
        ),
      ),
    );
  }

  Drawer drawer() {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueAccent[100],
            ),
            child: const Text("header"),
          )
          
        ],
      ),
    );
  }
}

const List<Map<String, dynamic>> data = [
  {
    "name": "asta",
    "text": "heiii",
    "dateTime": "10.12",
  },
  {
    "name": "yuno",
    "text": "heiii",
    "dateTime": "10.12",
  },
  {
    "name": "lucifero",
    "text": "heiii",
    "dateTime": "10.12",
  },
  {
    "name": "julius",
    "text": "heiii",
    "dateTime": "10.12",
  },
  {
    "name": "yami",
    "text": "heiii",
    "dateTime": "10.12",
  },
  {
    "name": "luck",
    "text": "heiii",
    "dateTime": "10.12",
  },
  {
    "name": "luis",
    "text": "heiii",
    "dateTime": "10.12",
  }
];
