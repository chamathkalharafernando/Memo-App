import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memoapp/utilities/dependencies.dart' as dependencies;

class SignInDialog extends StatefulWidget {
  const SignInDialog({super.key});

  @override
  State<SignInDialog> createState() => _SignInDialogState();
}

class _SignInDialogState extends State<SignInDialog> {
  RxString status = 'credentials'.obs;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  Widget credentialsWidget() {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        const SizedBox(height: 50),
        Text(
          'Sign In to Memo Account',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 50),
        SizedBox(
          width: 300,
          child: TextFormField(
            decoration: const InputDecoration(
              hintText: 'Email',
            ),
            controller: emailController,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 300,
          child: TextFormField(
            decoration: const InputDecoration(
              hintText: 'Password',
            ),
            controller: passwordController,
            obscureText: true, // Added to obscure the password
          ),
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Sign In'),
              onPressed: () {
                if (emailController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty) {
                  status.value = 'signing-in';
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: const Text(
                          'Fill in all the credentials',
                          textAlign: TextAlign.center,
                        ),
                        actions: [
                          ElevatedButton(
                            child: const Text('Close'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget signingWidget() {
    return FutureBuilder(
      future: Get.find<dependencies.AuthController>().signIn(
        emailController.text,
        passwordController.text,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Signing In'),
                SizedBox(height: 30),
                CircularProgressIndicator(),
              ],
            ),
          );
        } else {
          String resultMessage =
              snapshot.data ?? 'Error occurred'; // Default value for null
          if (resultMessage == 'success') {
            Future.delayed(
              const Duration(seconds: 1),
              () {
                Get.offNamed('/memo_page');
              },
            );
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Successfully signed in'),
                  SizedBox(height: 20),
                  CircularProgressIndicator(),
                ],
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(resultMessage),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: const Text('Try Again'),
                        onPressed: () {
                          status.value = 'credentials';
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => status.value == 'credentials'
            ? credentialsWidget()
            : signingWidget(),
      ),
    );
  }
}
