import 'package:flutter/material.dart';
import 'package:flutter_app_chat/login_page/login_page.dart';
import 'package:flutter_app_chat/login_page/sign_up_page.dart';

class HomeFirst extends StatelessWidget {
  const HomeFirst({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth <= 600) {
            return mobile(context);
          }
          return dekstop();
        },
      ),
    );
  }

  Row dekstop() {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: Colors.amber,
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.lightGreen,
          ),
        ),
      ],
    );
  }

  Column mobile(context) {
    // ignore: unused_local_variable
    final widith = MediaQuery.of(context).size.width;
    // ignore: unused_local_variable
    final height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Expanded(
          flex: 7,
          child: Stack(
            children: [
              Center(
                child: Image.asset(
                  "assets/images/firs.png",
                  height: 550,
                  width: 550,
                ),
              )
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.blue,
            child: ListView(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 15, color: Colors.black54),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SignUpPage(),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
                    ),
                    child: const Text(
                      "Sig Up",
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
