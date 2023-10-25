import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/auth/auth.dart';
import 'package:flutter_firebase/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    bool isSignedIn = false;

    return isSignedIn ? const Home() : const Auth();
  }
}
