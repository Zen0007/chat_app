import 'package:web_socket_channel/web_socket_channel.dart';

class AddContact {
  late WebSocketChannel channel;

  void connect() {
    channel = WebSocketChannel.connect(
      Uri.parse("ws://localhost:8080/ws/addCountact"),
    );
  }

  void sendMessage(dynamic data) {
    channel.sink.add(data);
  }

  void close() {
    channel.sink.close();
  }
}
