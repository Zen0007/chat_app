import 'package:flutter/material.dart';
import 'package:flutter_app_chat/room_chat/room_chat.dart';

class Contact extends StatelessWidget {
  const Contact(
      {super.key,
      required this.name,
      required this.image,
      this.text,
      this.dataTime});
  final String name;
  final String? text;
  final String? dataTime;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => RoomChat(
          ownRoom: name,
          image: image,
        ),
      )),
      child: Container(
        padding: EdgeInsets.only(bottom: 10, top: 10),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.elliptical(20, 20),
            bottomRight: Radius.elliptical(20, 20),
          ),
          color: Colors.blue[50],
        ),
        child: Row(
          spacing: 2,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 15),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(
                    image: AssetImage(
                      image,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Column(
              spacing: 2.7,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  name.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
                Text(
                  "$text",
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      "$dataTime",
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
