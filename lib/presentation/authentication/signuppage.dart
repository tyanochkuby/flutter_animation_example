import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations_example/main.dart';

import '../widgets/screentitle.dart';
import '../widgets/textformfieldboatbound.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        color: Colors.grey,
        child: Expanded(
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const ScreenTitle(title: 'Login Page'),
                  const SizedBox(height: 20),
                  TextFormFieldBoatBound(
                    controller: emailController,
                    labelText: 'Email',
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) =>
                        email != null && EmailValidator.validate(email)
                            ? null
                            : 'Enter a valid email',
                  ),
                  const SizedBox(height: 20),
                  TextFormFieldBoatBound(
                    controller: passwordController,
                    labelText: 'Password',
                    isHiden: isPasswordVisible,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (password) =>
                        password != null && password.length >= 8
                            ? null
                            : 'Enter a valid password',
                  ),
                  TextFormFieldBoatBound(
                    controller: confirmPasswordController,
                    labelText: 'Password',
                    isHiden: isPasswordVisible,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (cP) =>
                        cP != null && cP == passwordController.text
                            ? null
                            : 'Passwords do not match',
                  ),
                  Checkbox(
                      value: isPasswordVisible,
                      onChanged: (newValue) => setState(() {
                            isPasswordVisible = newValue!;
                          })),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      signUp(context);
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  signUp(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));
    try {
      FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    if (FirebaseAuth.instance.currentUser != null) {
      navigatorKey.currentState!.pop();
    }
  }
}
