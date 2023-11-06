import 'package:flutter/material.dart';
import 'package:flutter_sandbox/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie app',
      theme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: 'poppins',
          iconTheme: const IconThemeData(color: Colors.white),
          textTheme: const TextTheme(
              bodyMedium: TextStyle(
                color: Colors.white,
              ),
              bodyLarge: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              titleLarge: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
          scaffoldBackgroundColor: const Color(0xFF191a2c),
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
            TargetPlatform.android: ZoomPageTransitionsBuilder()
          })),
      debugShowCheckedModeBanner: false,
      home: Container(
        color: const Color(0xFF191a2c),
        child: const SafeArea(
          bottom: false,
          child: MainPage(),
        ),
      ),
    );
  }
}
