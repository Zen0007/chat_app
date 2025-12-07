import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class GetContact {
  WebSocketChannel? channel;
  Map<String, String>? userProlile;

  Future<void> initProfile() async {
    final box = await Hive.openBox("auth");
    userProlile = box.get("profile");
  }

  Future<void> connect() async {
    // if (userProlile == null) {
    //   await initProfile();
    // }

    channel = WebSocketChannel.connect(
      Uri.parse("ws://localhost:8080/ws/getContact"),
    );

    channel!.sink.add(
      jsonEncode(
        {
          "userId": "000791832",
        },
      ),
    );
  }

  Stream<List> friend() async* {
    final box = await Hive.openBox("contact");
    final chek = box.get("friend");
    print("$chek  +");
    if (chek != null) {
      yield chek;
    }
  }

  void put(dynamic event) async {
    final box = await Hive.openBox("contact");
    box.put("friend", jsonDecode(event));
  }

  void close() {
    channel!.sink.close();
  }
}
