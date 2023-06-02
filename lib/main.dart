import 'package:chat_app/screens/auth_screen.dart';
import 'package:chat_app/screens/chat_screen_data.dart';
import 'package:chat_app/screens/splash_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        canvasColor: Colors.black54,
          primaryColor: Colors.pink,
          primaryIconTheme:IconThemeData(color: Colors.black) ,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
              .copyWith(background: Colors.pink)
              .copyWith(secondary: Colors.deepPurple),
          buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Colors.pink,
            textTheme: ButtonTextTheme.primary,

            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          )),
      home:StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder:(ctx,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            SplashScreen();
          }
          if(snapshot.hasData){
            return ChatScreen();
          }
          else{
            return AuthScreen();
          }
        },
      ),
    );
  }
}
