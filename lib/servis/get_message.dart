import 'dart:io';

Future<void> getMessage() async {
  final ws = WebSocket.connect("");

  print(ws);
}
