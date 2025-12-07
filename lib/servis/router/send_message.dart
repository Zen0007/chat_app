import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

class SendMessage {
  late WebSocketChannel channel;

  void connect() {
    channel = WebSocketChannel.connect(
      Uri.parse("ws://localhost:8080/ws/sendMessage"),
    );
  }

  void send(dynamic data) {
    channel.sink.add(jsonEncode(data));
  }

  
}
