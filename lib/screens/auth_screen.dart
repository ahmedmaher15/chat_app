import 'dart:io';

import 'package:chat_app/widgets/auth/Auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isloding = false;
  final _auth = FirebaseAuth.instance;

  void submitAuthForm(String email, String password, String username,File? image,
      bool isLogin, BuildContext ctx) async {
    UserCredential _authResult;
    try {
      setState(() {
        _isloding = true;
      });
      if (isLogin) {
        _authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        _authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        final ref =await FirebaseStorage.instance.ref()
            .child('user_image')
            .child(_authResult.user!.uid + '.jpg');
        await ref.putFile(image!);
        final url=await ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection("users")
            .doc(_authResult.user!.uid).set({
          'username': username,
          'password':password,
          'image_url': url,
            });
      }
    } on FirebaseAuthException catch (e) {
      String message = "error Occurred";
   setState(() {
     if (e.code == 'weak-password') {
       message = 'the password provided is too weak';
     } else if (e.code == 'email-already-in-use') {
       message = "the account already exists for that email";
     } else if (e.code == 'user-not-found'){
       message = 'No user found for that email.';
     } else if (e.code == 'wrong-password') {
       message = 'Wrong password provided for that user.';
     }
   });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(ctx).colorScheme.error,
      ));
      setState(() {
        _isloding = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _isloding = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(submitAuthForm,_isloding),
    );
  }
}
