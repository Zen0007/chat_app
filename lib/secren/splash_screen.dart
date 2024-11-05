import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 112, 203, 249),
      body: Center(
        child: Stack(
          children: [
            const Center(
              child: SizedBox(
                width: 150,
                height: 150,
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
            Center(
              child: Container(
                width: 250,
                height: 100,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                  color: Color.fromARGB(255, 4, 240, 165),
                ),
              ),
            ),
            Center(
              child: Text(
                "Loading ...",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onError,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
