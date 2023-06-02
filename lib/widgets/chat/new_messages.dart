import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({Key? key}) : super(key: key);

  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  _sendMessage() async{
    FocusScope.of(context).unfocus();
    final user=  FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();
    FirebaseFirestore.instance.collection("chat").add({
      'text': _enterMessage,
      'createdAt': Timestamp.now(),
       'username':userData['username'],
       'userId':user?.uid,
      'userImage':userData['image_url'],
    });
    _controller.clear();
    setState(() {
      _enterMessage1 = "";
    });
  }
  final _controller = TextEditingController();
  String _enterMessage = "";
  String _enterMessage1 = '';
  @override
  Widget build(BuildContext context) {
    return Container (
      margin: EdgeInsets.only(top: 8,left: 3),
      padding: EdgeInsets.all(8),

      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              style: TextStyle(color: Colors.white),
              autocorrect: true,
              enableSuggestions: true,
              textCapitalization: TextCapitalization.sentences,
              controller: _controller,
              decoration:  InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor
                  )
                ),
                  hintText: 'Send a message.....',
                hintStyle: TextStyle(color: Theme.of(context).primaryColor),


              ),
              onChanged: (val) {
                setState(() {
                  _enterMessage1 = val;
                });
              },
            ),
          ),
          IconButton(
              onPressed: _enterMessage1.trim().isEmpty
                  ? null : () {setState(() {_enterMessage = _enterMessage1;});
                      _sendMessage();
                    },
            color: Theme.of(context).primaryColor,
            disabledColor: Colors.white,
              icon:Icon(Icons.send) ,


          ),
        ],
      ),
    );
  }
}
