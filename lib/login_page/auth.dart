import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app_chat/widget/user_image.dart';

final _firebase = FirebaseAuth.instance;

class Auth extends StatefulWidget {
  const Auth({super.key});
  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final _fromKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String enterEmail = '';
  String password = '';
  File? _seleckImage;
  bool _isLoding = false;
  String _userName = '';

  void _sumbit() async {
    final isValid = _fromKey.currentState!.validate();
    if (!isValid || !_isLogin && _seleckImage == null) return;
    _fromKey.currentState!.save();
    try {
      setState(() {
        _isLoding = true;
      });
      if (_isLogin) {
        final authlogin = await _firebase.signInWithEmailAndPassword(
            email: enterEmail, password: password);
        debugPrint("$authlogin");
      } else {
        final authLogin = await _firebase.createUserWithEmailAndPassword(
          email: enterEmail,
          password: password,
        );
        final storageRef = FirebaseStorage.instance
            .ref()
            .child("user_image")
            .child("${authLogin.user!.uid}.jpg");
        await storageRef.putFile(_seleckImage!);

        final getImage = await storageRef.getDownloadURL();

        final userId = FirebaseAuth.instance.currentUser!;

        final apiUrl = Uri.parse(
            'https://chat-app-8122b-default-rtdb.asia-southeast1.firebasedatabase.app/userData.json');
        http.post(
          apiUrl,
          headers: {"Content-Type": "application/json"},
          body: json.encode(
            {
              "id": userId.uid,
              "userName": _userName,
              "email": enterEmail,
              "userImage": _seleckImage,
            },
          ),
        );

        debugPrint(getImage);
        debugPrint("$authLogin  auth user");
        if (!mounted) return;
      }
      if (!mounted) return;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        //..
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'Authhenticaton is failed'),
        ),
      );
      setState(() {
        _isLoding = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final widith = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container(
              //   margin: const EdgeInsets.only(
              //     bottom: 20,
              //     top: 30,
              //     left: 20,
              //     right: 20,
              //   ),
              //   width: 200,
              //   color: const Color.fromARGB(255, 200, 110, 110),
              // ),
              if (widith < 600)
                Card(
                  margin: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: inputUser(context),
                  ),
                )
              else
                Stack(
                  alignment: Alignment.topCenter,
                  fit: StackFit.loose,
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                      width: 300,
                      height: 400,
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          color: Color.fromARGB(255, 226, 230, 233),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            SingleChildScrollView(
                              child: inputUser(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: -60,
                      child: UserImage(
                        pickImage: (pickImage) {
                          _seleckImage = pickImage;
                        },
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Padding inputUser(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _fromKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // if (!_isLogin)
            //   UserImage(
            //     pickImage: (pickImage) {
            //       _seleckImage = pickImage;
            //     },
            //   ),
            const SizedBox(
              height: 15,
            ),
            if (!_isLoding)
              TextFormField(
                decoration: const InputDecoration(labelText: 'user name'),
                enableSuggestions: false,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length < 4) {
                    return "Please enter at least 4 characters";
                  }
                  return "";
                },
                onSaved: (newValue) {
                  _userName = newValue!;
                },
              ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: "Email Address",
                  counterStyle: TextStyle(backgroundColor: Colors.black)),
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              textCapitalization: TextCapitalization.none,
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty ||
                    !value.contains("@")) {
                  return 'Please enter a valid email address.';
                }
                return "";
              },
              onSaved: (newValue) {
                enterEmail = newValue!;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Password",
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.trim().length < 6) {
                  return 'Password must be at least 6 characters long.';
                }
                return "";
              },
              onSaved: (newValue) {
                password = newValue!;
              },
            ),
            const SizedBox(
              height: 50,
            ),
            if (_isLoding) const CircularProgressIndicator(),
            if (!_isLoding)
              ElevatedButton(
                onPressed: _sumbit,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                ),
                child: Text(_isLogin ? "Login" : "Sign Up"),
              ),
            const SizedBox(
              height: 20,
            ),
            if (!_isLoding)
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isLogin = !_isLogin;
                  });
                },
                child: Text(_isLogin
                    ? "Create an account"
                    : "I already have an account"),
              ),
          ],
        ),
      ),
    );
  }
}
