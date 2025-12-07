import 'package:flutter/material.dart';
import 'package:flutter_app_chat/room_chat/room_chat.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(100, 0, 147, 233),
        ),
      ),
      // home: StreamBuilder(
      //   stream: verify(),
      //   builder: (context, snapshot) {
      //     if (snapshot.data == true) {
      //       print(snapshot.data!);
      //       return Home();
      //     } else {
      //       return Register();
      //     }
      //   },
      // ),
      home: RoomChat(ownRoom: "Asta", image: null),
    );
  }
}
