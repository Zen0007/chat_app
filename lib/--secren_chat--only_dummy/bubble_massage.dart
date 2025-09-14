import 'package:flutter/material.dart';

class MassageBubble extends StatelessWidget {
  const MassageBubble.fist({
    super.key,
    required this.userImage,
    required this.userName,
    required this.massage,
    required this.isMe,
  }) : isFistInSequence = true;

  const MassageBubble.next(
      {super.key, required this.massage, required this.isMe, this.userName})
      : isFistInSequence = false,
        userImage = null;

  final bool isFistInSequence;
  final String? userName;
  final String? userImage;
  final String massage;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        if (userImage != null)
          Positioned(
            top: 15,
            right: isMe ? 0 : 10,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                userImage!,
              ),
              backgroundColor: theme.colorScheme.inversePrimary.withAlpha(180),
              radius: 23,
            ),
          ),
        Positioned(
          bottom: 20,
          left: isMe ? 290 : 470,
          child: Text("1234"),
        ),
        Container(
          //color: Colors.red,
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  if (isFistInSequence) const SizedBox(height: 18),
                  Container(
                    decoration: BoxDecoration(
                      color: isMe ? Colors.amberAccent[200] : Colors.grey[400],
                      borderRadius: BorderRadius.only(
                        topLeft: !isMe || isFistInSequence
                            ? const Radius.circular(12)
                            : Radius.zero,
                        topRight: isMe || isFistInSequence
                            ? const Radius.circular(12)
                            : Radius.zero,
                        bottomLeft: const Radius.circular(12),
                        bottomRight: const Radius.circular(12),
                      ),
                    ),
                    constraints: const BoxConstraints(maxWidth: 450),
                    padding: const EdgeInsets.symmetric(
                      vertical: 9,
                      horizontal: 14,
                    ),
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 12,
                    ),
                    child: Text(
                      massage,
                      style: TextStyle(
                          height: 1.3,
                          color: const Color.fromARGB(221, 0, 0, 0)),
                      softWrap: true,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
