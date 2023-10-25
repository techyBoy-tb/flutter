import 'package:firebase/screens/auth/signIn.dart';
import 'package:firebase/screens/auth/signUp.dart';
import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showSignIn
        ? SignIn(toggleSignUp: toggleView)
        : SignUp(toggleSignIn: toggleView);
  }
}
