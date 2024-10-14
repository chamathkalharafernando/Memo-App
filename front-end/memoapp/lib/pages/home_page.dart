import 'package:flutter/material.dart';
import 'package:memoapp/dialogs/sign_in_dialog.dart';
import 'package:memoapp/dialogs/create_account_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topLeft,
                radius: 1.0,
                colors: [
                  Colors.white,
                  Color(0xff5debd7),
                  Colors.white,
                ],
              ),
            ),
          ),
          // Main content centered
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Memo App',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                // Logo
                Image.asset(
                  'images/favicon.png',
                  height: 70,
                ),
                const SizedBox(height: 50),
                // Sign In Button
                ElevatedButton(
                  child: const Text('Sign In'),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const SignInDialog();
                      },
                    );
                  },
                ),
                const SizedBox(height: 25),
                // Create Account Button
                ElevatedButton(
                  child: const Text('Create Account'),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const CreateAccountDialog();
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
