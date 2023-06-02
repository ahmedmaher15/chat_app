import 'package:chat_app/widgets/chat/messages.dart';
import 'package:chat_app/widgets/chat/new_messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        actions: [
          DropdownButton(
            underline: Container(),
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                  child: Row(
                    children: [
                      Icon(
                        Icons.exit_to_app,
                        color: Theme.of(context).primaryIconTheme.color,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text("Logout",style: TextStyle(color: Colors.white),)
                    ],
                  ),
                  value: "logout",
                )
              ],
              onChanged: (itemIdentfire) {
                if (itemIdentfire == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              })
        ],
        title:  Text("chaty " ),
      ),
      body:  Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("images/background.png",),fit: BoxFit.cover)
        ),
        child: Column(
             children: [
               Expanded(child: Messages()),
               Container(
                   decoration: BoxDecoration(
                       color: Colors.black87,
               borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
    ), child: NewMessages()),
             ],
           ),
      ),



    );
  }
}
