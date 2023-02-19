import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
                child: SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          ElevatedButton(
            onPressed: () {
              context.goNamed('logIn');
            },
            child: const Text('Log in'),
          ),
          const SizedBox(width: 12.0),
          ElevatedButton(
            onPressed: () {
              context.goNamed('signUp');
            },
            child: const Text('Sign up'),
          ),
        ],
      ),
    ))));
  }
}
