import 'package:flutter/material.dart';
import 'package:flutter_app_chat/dummy_data/contact_data.dart';
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
                      onPressed: () => scaffoldKey.currentState!.openDrawer(),
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
      drawer: drawer(),
      backgroundColor: Colors.blueAccent[100],
      body: Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 20),
        child: ListView.builder(
          itemCount: data.length,
          physics: ScrollPhysics(),
          itemBuilder: (context, index) {
            return Contact(
              name: data[index]['name'],
              text: data[index]["text"],
              dataTime: data[index]["dateTime"],
              image: data[index]["image"],
            );
          },
        ),
      ),
    );
  }

  Drawer drawer() {
    return Drawer(
      backgroundColor: Colors.white70,
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueAccent[200],
            ),
            child: const Text("header"),
          ),
        ],
      ),
    );
  }
}
