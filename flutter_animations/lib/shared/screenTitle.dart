import 'package:flutter/material.dart';

class ScreenTitle extends StatelessWidget {
  final String text;

  const ScreenTitle({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 500),
      tween: Tween<double>(begin: 0, end: 1),
      child: Text(
        text,
        style: const TextStyle(fontSize: 36, color: Colors.white, fontWeight: FontWeight.bold),
      ),
      builder: (BuildContext context, double val, Widget? child) {
        return Opacity(
            opacity: val,
            child: Padding(
              padding: EdgeInsets.only(top: val * 20),
              child: child,
            )
        );
      },
    );
  }
}