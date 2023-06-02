
import 'dart:io';

import 'package:chat_app/pickers/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(String email, String password, String username,File? image,
      bool isLogin, BuildContext ctx) submitfn;
  final bool _islogin;
   AuthForm(this.submitfn,this._islogin, {super.key});
  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _email = '';
  String _password = '';
  String _userName = '';
   File? _userImageFile;
  void pickImage(File pickedImage){
    _userImageFile=pickedImage;
  }
  void _supmit() {
    final isValid = _formkey.currentState?.validate();
    FocusScope.of(context).unfocus();
    if(!_isLogin && _userImageFile==null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please select image"),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
      return  print("errot yabny");}
    if(isValid== true){
      _formkey.currentState!.save();
     widget.submitfn(_email.trim(),_password.trim(),_userName.trim(),_userImageFile,_isLogin,context);
    }
  }
  @override
  Widget build(BuildContext ss) {
    return Container(
  color: Colors.pink,
      child: Center(
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 3,
          margin: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if(!_isLogin)UserImagePicker(pickImage),
                  TextFormField(
                    key: const ValueKey('email'),
                    autocorrect: false,
                    enableSuggestions: false,
                    textCapitalization: TextCapitalization.none,
                    validator: (val) {
                      if (val!.isEmpty || !val.contains("@")) {
                        return "Please Enter a valid number";
                      }
                      return null;
                    },
                    onSaved: (val) => _email = val!,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(labelText: "Email Address"),
                  ),
                  if (!_isLogin)
                    TextFormField(
                      autocorrect: true,
                      enableSuggestions: false,
                      textCapitalization: TextCapitalization.words,
                      key: const ValueKey('username'),
                      validator: (val) {
                        if (val!.isEmpty || val.length < 4) {
                          return "Please Enter a at least 4 characters";
                        }
                        return null;
                      },
                      onSaved: (val) => _userName = val!,
                      decoration: const InputDecoration(labelText: "Username"),
                    ),
                  TextFormField(
                    key: const ValueKey('password'),
                    validator: (val) {
                      if (val!.isEmpty || val.length < 7) {
                        return "Please Enter at least 7 characters";
                      }
                      return null;
                    },
                    onSaved: (val) => _password = val!,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(labelText: "Password"),
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  if(widget._islogin==true)
                    const CircularProgressIndicator()
                  ,
                  if(widget._islogin!=true)
                  ElevatedButton(
                    onPressed: _supmit
                    ,
                  style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                    child: Text(_isLogin ? 'LogIn' : 'Sign Up',style: const TextStyle(fontSize: 15),),
                  ),
                  if(widget._islogin!=true)
                  TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(_isLogin
                          ? 'Creat new account'
                          : 'I already have an account'),

                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
