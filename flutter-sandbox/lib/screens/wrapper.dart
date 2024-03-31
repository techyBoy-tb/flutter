import 'package:flutter/material.dart';
import 'package:flutter_sandbox/model/CustomUser.dart';
import 'package:flutter_sandbox/screens/auth/auth.dart';
import 'package:flutter_sandbox/screens/nav.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);

    bool isSignedIn = user != null;

    return Container(
        color: const Color(0xFF191a2c),
        child: SafeArea(
          bottom: false,
          child: isSignedIn ? const Nav() : const Auth(),
        ));
  }
}
