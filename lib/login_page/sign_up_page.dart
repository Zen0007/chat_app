import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _firebase = FirebaseAuth.instance;
  final _fromKey = GlobalKey<FormState>();
  String nameUser = '';
  String emailUser = '';
  bool isLoding = false;
  String password = '';
  final Color colors =
      const Color.fromARGB(100, 128, 208, 199).withOpacity(0.5);

  void signUp() async {
    final isValid = _fromKey.currentState!.validate();
    if (!isValid) return;
    _fromKey.currentState!.save();
    try {
      setState(() {
        isLoding = true;
      });
      final authLogin = await _firebase.createUserWithEmailAndPassword(
        email: emailUser,
        password: password,
      );

      final userId = FirebaseAuth.instance.currentUser!;

      final apiUrl = Uri.parse(
          'https://chat-app-8122b-default-rtdb.asia-southeast1.firebasedatabase.app/userData.json');
      http.post(
        apiUrl,
        headers: {"Content-Type": "application/json"},
        body: json.encode(
          {
            "id": userId.uid,
            "userName": nameUser,
            "email": emailUser,
          },
        ),
      );

      debugPrint("$authLogin");
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        AlertDialog.adaptive(
          title: const Text('email is alreadu in use'),
          actions: [
            FloatingActionButton(onPressed: () => Navigator.of(context).pop)
          ],
        );
      }
    }
    setState(() {
      isLoding = false;
    });
    _fromKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final widith = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth <= 600) {
            return mobile(context);
          } else {
            return Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.amber,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Column mobile(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 7,
          child: Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _fromKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: ' UserName',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor: colors,
                          filled: true,
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(16),
                            child: Icon(Icons.person),
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                        enableSuggestions: false,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.trim().length < 4) {
                            return "Please enter at least 4 characters";
                          }
                          return null;
                        },
                        onSaved: (newValue) => nameUser = newValue!,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: " Email Address",
                          counterStyle: const TextStyle(
                            backgroundColor: Colors.black,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor: colors,
                          filled: true,
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(16),
                            child: Icon(Icons.email),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              !value.contains("@")) {
                            return 'Please enter a valid email address.';
                          }
                          return null;
                        },
                        onSaved: (newValue) => emailUser = newValue!,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: ' password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor: colors,
                          filled: true,
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(16),
                            child: Icon(Icons.password),
                          ),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 6) {
                            return 'Password must be at least 6 characters long.';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          debugPrint(newValue);
                          password = newValue!;
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: ListView(
            children: [
              if (isLoding)
                Center(
                  child: Container(
                    height: 50,
                    width: 350,
                    margin: const EdgeInsets.only(
                      right: 20,
                      left: 20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                    child: const Center(
                        child: CircularProgressIndicator.adaptive()),
                  ),
                ),
              if (!isLoding) ...[
                Container(
                  margin: const EdgeInsets.only(right: 20, left: 20, top: 20),
                  child: ElevatedButton(
                    onPressed: signUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                    child: const Center(child: Text("Sign Up")),
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     const Text("data"),
                //     GestureDetector(
                //       onTap: () {},
                //       child: Text(
                //         '  data',
                //         style: TextStyle(
                //           color: Theme.of(context).colorScheme.primary,
                //           fontWeight: FontWeight.bold,
                //           fontSize: 17,
                //         ),
                //       ),
                //     )
                //   ],
                // ),
                // Container(
                //   margin: const EdgeInsets.only(right: 20, left: 20, top: 20),
                //   child: ElevatedButton(
                //     onPressed: () => Navigator.of(context).pop(),
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: Theme.of(context).colorScheme.onPrimary,
                //     ),
                //     child: const Center(child: Text("Back")),
                //   ),
                // ),
              ]
            ],
          ),
        ),
      ],
    );
  }
}
