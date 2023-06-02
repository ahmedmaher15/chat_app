import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(this.message, this.userName, this.userImage, this.isMe, {this.key});

  @override
  final String userImage;
  final Key? key;
  final String message;
  final String userName;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none, children: [
      Row(
        mainAxisAlignment:
            isMe != true ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                color: isMe != true
                    ? Color.fromRGBO(32,44,51,1)
                    : Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(14),
                    topRight: const Radius.circular(14),
                    bottomLeft: isMe != false
                        ? const Radius.circular(0)
                        : const Radius.circular(14),
                    bottomRight: isMe != true
                        ? const Radius.circular(0)
                        : const Radius.circular(14))),
            width: 140,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Column(
              crossAxisAlignment: isMe != true
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: TextStyle(
                    fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: isMe != true
                          ? Colors.white
                          // ignore: deprecated_member_use
                          : Color(0xFFFDFDFD)),
                ),
                Text(
                  message,
                  style: TextStyle(
                      color: isMe != true
                          ? Colors.grey
                          // ignore: deprecated_member_use
                          : Colors.black,fontSize: 15,fontWeight: FontWeight.w500),

                  textAlign: isMe != true ? TextAlign.end : TextAlign.start,
                )
              ],
            ),
          )
        ],
      ),
      Positioned(

          left:isMe? 120:null,
          right: !isMe?120:null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(userImage),
          ))
    ]);
  }
}
