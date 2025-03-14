import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _firebase = FirebaseAuth.instance;
  final _fromKey = GlobalKey<FormState>();
  String emailUser = '';
  bool isLoding = false;
  String password = '';
  final Color colors = const Color.fromARGB(100, 128, 208, 199).withAlpha(50);

  void _login() async {
    final validate = _fromKey.currentState!.validate();
    if (!validate) return;
    _fromKey.currentState!.save();
    try {
      setState(() {
        isLoding = true;
      });
      final authLogin = await _firebase.signInWithEmailAndPassword(
          email: emailUser, password: password);
      debugPrint("$authLogin");
      if (!mounted) {
        return;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        AlertDialog.adaptive(
          title: Text(e.message ?? 'Authhenticaton is failed'),
          actions: [
            FloatingActionButton(onPressed: () => Navigator.of(context).pop)
          ],
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        textInputAction: TextInputAction.next,
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
                        textInputAction: TextInputAction.next,
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
              if (isLoding) const CircularProgressIndicator(),
              if (!isLoding)
                Container(
                  margin: const EdgeInsets.only(right: 20, left: 20),
                  child: ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
                    ),
                    child: const Center(child: Text("Login")),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
