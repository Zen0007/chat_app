import 'package:flutter/material.dart';
import 'package:flutter_app_chat/servis/auth/register.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  @override
  State<Register> createState() => _Register();
}

class _Register extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = false;
  String enterEmail = '';
  String password = '';
  bool _isLoading = false;
  // ignore: unused_field
  String _userName = '';

  void _submit() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      Future.delayed(
        const Duration(seconds: 2),
        () => _formKey.currentState!.reset(),
      );
      return;
    }

    _formKey.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    final registerUser = await register({
      "name": _userName,
      "email": enterEmail,
      "password": password,
    });

    if (!mounted) return;

    if (registerUser.containsKey("success")) {
      alert(registerUser["success"]!);
    } else {
      alert(registerUser["error"]!);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void alert(String registerUser) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        content: Text(registerUser),
        actions: [
          TextButton(
            child: Text("oke"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Container(
          width: 400,
          height: 400,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            color: Color.fromARGB(255, 226, 230, 233),
          ),
          child: SingleChildScrollView(
            child: inputUser(context),
          ),
        ),
      ),
    );
  }

  Column coll() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.topCenter,
          fit: StackFit.loose,
          clipBehavior: Clip.none,
          children: [
            // SizedBox(
            //   width: 400,
            //   height: 400,
            //   child: DecoratedBox(
            //     decoration: const BoxDecoration(
            //       borderRadius: BorderRadius.all(
            //         Radius.circular(20),
            //       ),
            //       color: Color.fromARGB(255, 226, 230, 233),
            //     ),
            //     child: SingleChildScrollView(
            //       child: inputUser(context),
            //     ),
            //   ),
            // ),
            // if (!_isLogin)
            //   Positioned(
            //     top: -60,
            //     child: UserImage(
            //       pickImage: (pickImage) {
            //         _selectImage = pickImage;
            //       },
            //     ),
            //   ),
          ],
        ),
      ],
    );
  }

  Padding inputUser(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!_isLogin) ...[
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                enableSuggestions: false,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length < 6) {
                    return "Please enter at least 4 characters";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _userName = newValue!;
                },
              ),
              const SizedBox(
                height: 15,
              ),
            ],
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Email Address",
                counterStyle: TextStyle(
                  backgroundColor: Colors.black,
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
                if (value == null || value.trim().length < 8) {
                  return 'Password must be at least 8 characters long.';
                }
                return null;
              },
              onSaved: (newValue) {
                password = newValue!;
              },
            ),
            if (_isLogin)
              const SizedBox(
                height: 80,
              ),
            const SizedBox(
              height: 20,
            ),
            if (_isLoading) const CircularProgressIndicator(),
            if (!_isLoading)
              ElevatedButton(
                onPressed: () {
                  _submit();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                ),
                child: Text(_isLogin ? "Login" : "Sign Up"),
              ),
            const SizedBox(
              height: 20,
            ),
            if (!_isLoading)
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isLogin = !_isLogin;
                  });
                },
                child: Text(
                  _isLogin ? "Create an account" : "I already have an account",
                ),
              ),
          ],
        ),
      ),
    );
  }
}
