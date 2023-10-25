import 'package:firebase/models/CustomUser.dart';
import 'package:firebase/screens/auth/auth.dart';
import 'package:firebase/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);

    bool isSignedIn = user != null;

    return isSignedIn ? Home() : const Auth();
  }
}
