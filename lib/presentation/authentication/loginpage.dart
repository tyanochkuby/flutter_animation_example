import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations_example/main.dart';
import 'package:flutter_animations_example/presentation/authentication/signuppage.dart';
import 'package:flutter_animations_example/presentation/widgets/screentitle.dart';
import 'package:flutter_animations_example/presentation/widgets/square_tile.dart';
import 'package:flutter_animations_example/presentation/widgets/textfieldboatbound.dart';
import 'package:flutter_animations_example/services/google_auth_service.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Align(
        alignment: Alignment.center,
        child: Hero(
          transitionOnUserGestures: true,
          tag: 'user-icon',
          child: Material(
            child: Container(
              color: Color.fromARGB(255, 200, 200, 200),
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
                  const SizedBox(height: 5),
                  TextButton(
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpPage())),
                    child: const Text('Sign Up'),
                  ),
                  const SizedBox(height: 5),
                  SquareTile(
                    onTap: () => GoogleAuthUtil.sighInWithGoogle(),
                    color: Colors.white,
                    child: Image.network(
                        'http://pngimg.com/uploads/google/google_PNG19635.png',
                        fit: BoxFit.cover),
                  )
                ],
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
