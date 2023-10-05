import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations_example/main.dart';
import 'package:flutter_animations_example/presentation/widgets/screentitle.dart';
import 'package:flutter_animations_example/presentation/widgets/textfieldboatbound.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        transitionOnUserGestures: true,
        tag: 'user-icon',
        child: Material(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            color: Colors.grey,
            child: Expanded(
              child: Center(
                child: Column(
                  children: [
                    const ScreenTitle(title: 'Login Page'),
                    const SizedBox(height: 20),
                    TextFieldBoatBound(
                      controller: emailController,
                      labelText: 'Email',
                    ),
                    const SizedBox(height: 20),
                    TextFieldBoatBound(
                      controller: passwordController,
                      labelText: 'Password',
                      isHiden: true,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => signIn(context),
                      child: const Text('Login'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future signIn(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
        ),
      );
    }
    if (FirebaseAuth.instance.currentUser != null) {
      navigatorKey.currentState!.pop();
    }
  }
}
