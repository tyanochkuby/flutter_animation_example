import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations_example/presentation/widgets/screentitle.dart';
import 'package:flutter_animations_example/presentation/widgets/textfieldboatbound.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
              onPressed: () => signIn(),
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  Future signIn() async =>
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
}
